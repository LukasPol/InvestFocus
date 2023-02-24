require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:code) }
    it { should validate_length_of(:code) }
    it { should validate_uniqueness_of(:code) }
  end

  describe 'search ransack' do
    context 'ransackable_attributes' do
      it { expect(Stock.ransackable_attributes).to eq(%w[code]) }
    end

    context 'ransackable_associations' do
      it { expect(Stock.ransackable_associations).to eq(%w[assets tradings]) }
    end
  end
end
