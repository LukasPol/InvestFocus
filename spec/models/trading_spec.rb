require 'rails_helper'

RSpec.describe Trading, type: :model do
  describe 'validates' do
    context 'presence' do
      it { should validate_presence_of(:value_unit) }
      it { should validate_presence_of(:total_value) }
      it { should validate_presence_of(:amount) }
      it { should validate_presence_of(:user) }
      it { should validate_presence_of(:asset) }
      it { should validate_presence_of(:stock) }
    end

    context 'validate numericality' do
      it { should validate_numericality_of(:value_unit).is_greater_than_or_equal_to(0) }
      it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
      it { should validate_numericality_of(:total_value).is_greater_than_or_equal_to(0) }
    end

    context 'date after today' do
      it 'should return error date after today' do
        trading = build(:trading, date: Date.tomorrow)

        expect(trading.valid?).to be_falsey
        expect(trading.errors.full_messages).to eq(['Data não pode ser do futuro'])
      end
    end

    context 'before validate set_stock' do
      it 'should create a new Stock' do
        expect { create(:trading, stock_code: 'TEST99') }.to(change { Stock.count })
      end
    end

    context 'before validate set_asset' do
      it 'should create a new Asset' do
        expect { create(:trading, asset: nil) }.to(change { Asset.count })
      end
    end
  end

  describe 'scopes' do
    it '.buy' do
      create_list(:trading, 3, :buy)

      expect(Trading.buy.count).to eq(3)
    end

    it '.sale' do
      create_list(:trading, 5, :sale)

      expect(Trading.sale.count).to eq(5)
    end

    it '.inplit' do
      create_list(:trading, 2, :inplit)

      expect(Trading.inplit.count).to eq(2)
    end
  end

  describe 'search ransack' do
    context 'ransackable_attributes' do
      it { expect(Trading.ransackable_attributes).to eq(%w[kind date]) }
    end

    context 'ransackable_associations' do
      it { expect(Trading.ransackable_associations).to eq(%w[stock]) }
    end
  end
end
