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
          params = Imports::SetParams.call(row, :inplit)
          create_inplit(params.merge(user:))
        when 'Transferência - Liquidação'
          params = Imports::SetParams.call(row, :trading)
          create_buy_or_sale(params.merge(user:))
        else
          params = Imports::SetParams.call(row, :proceed)
          create_proceed(params.merge(user:))
        end
      end

      importer.finish_upload

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

    def create_buy_or_sale(params)
      Trading.create(params)
    end

    def create_inplit(params)
      Trading.create(params)
    end

    def create_proceed(params)
      Proceed.create(params)
    end
  end
end
