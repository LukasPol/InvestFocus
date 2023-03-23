require 'rails_helper'

RSpec.describe Proceed, type: :model do
  let(:stock_code) { 'TEST3' }
  let(:user) { create(:user) }
  let!(:trading) { create(:trading, user:, stock_code:) }

  describe 'validates' do
    context 'presence' do
      it { should validate_presence_of(:value_unit) }
      it { should validate_presence_of(:total_value) }
      it { should validate_presence_of(:amount) }
      it { should validate_presence_of(:user) }
    end

    context 'validate numericality' do
      it { should validate_numericality_of(:value_unit).is_greater_than_or_equal_to(0) }
      it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
      it { should validate_numericality_of(:total_value).is_greater_than_or_equal_to(0) }
    end

    context 'date after today' do
      it 'should return error date after today' do
        proceed = build(:proceed, date: Date.tomorrow, user:, stock_code:)

        expect(proceed.valid?).to be_falsey
        expect(proceed.errors.full_messages).to eq(['Data não pode ser do futuro'])
      end
    end

    context 'before validate set_stock' do
      it 'should set the trading stock' do
        proceed = create(:proceed, user:, stock_code:)
        expect(proceed.stock).to eq(trading.stock)
      end

      context 'Error' do
        it 'should not create new stock if user dont have trading' do
          proceed = build(:proceed)
          expect(proceed.valid?).to be_falsey
          expect(proceed.errors.messages[:stock_code]).to include('Você não tem essa ação')
        end
      end
    end

    context 'before validate set_asset' do
      it 'should set the trading asset' do
        proceed = create(:proceed, user:, stock_code:)
        expect(proceed.asset).to eq(trading.asset)
      end

      context 'Error' do
        it 'should not create new stock if user dont have trading' do
          proceed = build(:proceed)
          expect(proceed.valid?).to be_falsey
          expect(proceed.errors.messages[:asset]).to include('Você não tem essa ação')
        end
      end
    end
  end

  describe '.update_proceed_asset' do
    it 'should change asset after create' do
      proceed = create(:proceed, user:, stock_code:, total_value: 100)

      expect(proceed.asset.proceed_received).to eq(100)
    end
  end
end
