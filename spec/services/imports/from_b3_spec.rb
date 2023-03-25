require 'rails_helper'

RSpec.describe Imports::FromB3 do
  let(:user) { create(:user) }

  let(:file) do
    Rack::Test::UploadedFile.new('spec/fixtures/acoes.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
  end

  let(:importer) { create(:importer) }

  describe '.call' do
    context 'success' do
      before :each do
        allow(importer).to receive(:file_url) do
          file
        end

        described_class.call(importer)
      end

      it 'should create record correct' do
        expect(Trading.count).to eq(8)
        expect(Asset.count).to eq(5)
        expect(Stock.count).to eq(5)
      end

      it 'should create the tradings with kind correct' do
        expect(Trading.buy.count).to eq(5)
        expect(Trading.sale.count).to eq(1)
        expect(Trading.inplit.count).to eq(2)
      end

      it 'should create the proceeds correct' do
        expect(Proceed.count).to eq(4)
      end
    end

    context 'fail' do
      it 'file not supported' do
        importer = create(:importer, :without_lines)
        allow(importer).to receive(:file_url) do
          ActiveStorage::Blob.service.path_for(importer.file.key)
        end

        expect(described_class.call(importer).errors).to eq(['Arquivo não suportado'])
      end

      it 'dont have kind Buy/Sale/Inplit' do
        importer = create(:importer, :others_kinds)
        allow(importer).to receive(:file_url) do
          ActiveStorage::Blob.service.path_for(importer.file.key)
        end

        expect(described_class.call(importer).errors).to eq(['Não tem nenhuma Compra/Venda/Grupamento'])
      end
    end
  end
end