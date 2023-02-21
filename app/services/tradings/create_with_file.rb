module Tradings
  class CreateWithFile
    attr_reader :file, :user, :errors

    def initialize(file, user)
      @user = user
      @file = convert_to_csv(file)
      @errors = []
    end

    def self.call(file, user)
      new(file, user).call
    end

    def call
      if !exists_rows? || file.nil?
        errors << { attachment: 'File not supported' }
        return errors
      end

      rows = set_rows

      if rows.empty?
        errors << { attachment: 'Não tem nenhuma Compra/Venda/Grupamento' }
        return errors
      end

      rows.each do |row|
        if row['Movimentação'] == 'Grupamento'
          create_inplit(row)
        else
          create_buy_or_sale(row)
        end
      end

      true
    end

    private

    def convert_to_csv(file)
      return CSV.read(file, headers: true, col_sep: ';') if file.content_type == 'text/csv'

      if file.content_type == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        temp_file = Roo::Excelx.new(file)
        filename = "tmp/storage/#{user.name}-#{DateTime.now}.csv"

        temp_file.to_csv(filename, ';')
        csv = CSV.read(filename, headers: true, col_sep: ';')
        File.delete(filename)

        return csv
      end

      nil
    end

    def exists_rows?
      file&.count&.positive?
    end

    def set_rows
      rows = file.select { |row| row['Movimentação'] == 'Transferência - Liquidação' || row['Movimentação'] == 'Grupamento' }
      rows.sort { |a, b| a['Data'].to_date <=> b['Data'].to_date }
      rows
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
  end
end
