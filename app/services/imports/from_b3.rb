module Imports
  class FromB3
    attr_reader :importer, :user

    def initialize(importer)
      @importer = importer
      @user = importer.user
      @errors = []
    end

    def self.call(importer)
      new(importer).call
    end

    def call
      unless exists_rows?
        @errors << { attachment: I18n.t(:file_not_supported, scope: 'errors.importer') }
        return self
      end

      rows = set_rows

      if rows.empty?
        @errors << { attachment: I18n.t(:without_kinds, scope: 'errors.importer') }
        return self
      end

      rows.each do |row|
        case row['Movimentação']
        when 'Grupamento'
          create_inplit(row)
        when 'Transferência - Liquidação'
          create_buy_or_sale(row)
        else
          create_proceed(row)
        end
      end

      true
    end

    def errors
      @errors.map(&:values).flatten
    end

    private

    def exists_rows?
      importer.file.nil? || file.nil? || file&.count&.positive?
    end

    def set_rows
      rows = file.select do |row|
        row['Movimentação'] == 'Transferência - Liquidação' ||
          row['Movimentação'] == 'Grupamento' ||
          row['Movimentação'] == 'Dividendo' ||
          row['Movimentação'] == 'Juros Sobre Capital Próprio'
      end
      rows.sort { |a, b| a['Data'].to_date <=> b['Data'].to_date }
      rows
    end

    def file
      return @file if @file.present?

      if importer.file.attachment.content_type == 'text/csv'
        @file = CSV.read(importer.file_url, headers: true, col_sep: ';')
        return @file
      end

      if importer.file.attachment.content_type == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        temp_file = Roo::Excelx.new(importer.file_url)
        filename = "tmp/storage/#{user.id}-#{DateTime.now}.csv"

        temp_file.to_csv(filename, ';')
        @file = CSV.read(filename, headers: true, col_sep: ';')
        File.delete(filename)

        return @file
      end

      nil
    end

    def format_value(value)
      value.delete(' R$')
      value.gsub!(',', '.')
      value.to_f
    end

    def get_stock_code(row)
      row['Produto'][0..4]
    end

    def create_buy_or_sale(row)
      stock_code = get_stock_code(row)
      amount = row['Quantidade']
      value_unit = format_value(row['Preço unitário'])
      total_value = format_value(row['Valor da Operação'])
      date = row['Data']
      kind = row['Entrada/Saída'] == 'Credito' ? 'buy' : 'sale'

      Trading.create(amount:, value_unit:, total_value:, date:, kind:, user:, stock_code:)
    end

    def create_inplit(row)
      stock_code = get_stock_code(row)
      amount = row['Quantidade']
      date = row['Data']

      Trading.create(kind: 'inplit', amount:, date:, stock_code:, user:)
    end

    def create_proceed(row)
      stock_code = get_stock_code(row)
      amount = row['Quantidade']
      value_unit = format_value(row['Preço unitário'])
      total_value = format_value(row['Valor da Operação'])
      date = row['Data']
      kind = row['Movimentação'] == 'Dividendo' ? 'dividends' : 'jcp'

      Proceed.create(amount:, value_unit:, total_value:, date:, kind:, user:, stock_code:)
    end
  end
end
