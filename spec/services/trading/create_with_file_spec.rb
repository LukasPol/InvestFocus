require 'rails_helper'

RSpec.describe Tradings::CreateWithFile do
  let(:user) { create(:user) }

  let(:file) do
    Rack::Test::UploadedFile.new('spec/fixtures/acoes.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
  end

  describe '.call' do
    context 'success' do
      it 'should create record correct' do
        expect(described_class.call(file, user)).to eq(true)
        expect(Trading.count).to eq(8)
        expect(Asset.count).to eq(5)
        expect(Stock.count).to eq(5)
      end

      it 'should create the tradings with kind correct' do
        described_class.call(file, user)
        expect(Trading.buy.count).to eq(5)
        expect(Trading.sale.count).to eq(1)
        expect(Trading.inplit.count).to eq(2)
      end
    end

    context 'fail' do
      it 'file not supported' do
        file = Rack::Test::UploadedFile.new('spec/fixtures/without_lines.csv', 'text/csv')

        expect(described_class.call(file, user)).to eq([{ attachment: 'File not supported' }])
      end

      it 'dont have kind Buy/Sale/Inplit' do
        file = Rack::Test::UploadedFile.new('spec/fixtures/with_others_kinds.csv', 'text/csv')

        expect(described_class.call(file, user)).to eq([{ attachment: 'Não tem nenhuma Compra/Venda/Grupamento' }])
      end
    end
  end
end
