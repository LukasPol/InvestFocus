require 'rails_helper'

RSpec.describe Assets::Updater do
  let(:user) { create(:user) }

  describe 'trading kind buy' do
    let(:trading) { create(:trading, amount: 10, value_unit: 2, total_value: 20, stock_code: 'TEST99', user:) }

    it { expect(trading.asset.amount).to eq(10) }
    it { expect(trading.asset.total_invested).to eq(20) }
    it { expect(trading.asset.average_price).to eq(2) }

    context 'with two tradings' do
      it 'check fields is correct' do
        create(:trading, amount: 5, value_unit: 3, total_value: 15, stock_code: 'TEST99', user:)

        expect(trading.asset.amount).to eq(15)
        expect(trading.asset.total_invested).to eq(35)
        expect(trading.asset.average_price).to eq(2.33)
      end
    end
  end

  describe 'trading kind sale' do
    before :each do
      create(:trading, amount: 50, value_unit: 2, total_value: 100, stock_code: 'TEST99', user:)
    end

    it 'buy after sale the stock' do
      trading = create(:trading, kind: :sale, amount: 10, value_unit: 3, total_value: 30, stock_code: 'TEST99', user:)

      expect(trading.asset.amount).to eq(40)
      expect(trading.asset.total_invested).to eq(80)
      expect(trading.asset.average_price).to eq(2)
    end

    it 'sale all stocks' do
      trading = create(:trading, kind: :sale, amount: 50, value_unit: 1, total_value: 50, stock_code: 'TEST99', user:)

      expect(trading.asset.amount).to eq(0)
      expect(trading.asset.total_invested).to eq(0)
      expect(trading.asset.average_price).to eq(0)
    end
  end

  describe 'trading kind inplit' do
    let(:trading) { create(:trading, kind: :inplit, amount: 10, stock_code: 'TEST99', user:) }

    before :each do
      create(:trading, amount: 100, value_unit: 2, total_value: 200, stock_code: 'TEST99', user:)
    end

    it { expect(trading.asset.amount).to eq(10) }
    it { expect(trading.asset.average_price).to eq(20) }
    it { expect(trading.asset.total_invested).to eq(200) }
  end
end
