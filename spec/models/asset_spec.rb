require 'rails_helper'

RSpec.describe Asset, type: :model do
  describe 'validates' do
    context 'presence' do
      it { should validate_presence_of(:average_price) }
      it { should validate_presence_of(:total_invested) }
      it { should validate_presence_of(:amount) }
      it { should validate_presence_of(:user) }
      it { should validate_presence_of(:stock) }
    end

    context 'validate numericality' do
      it { should validate_numericality_of(:average_price).is_greater_than_or_equal_to(0) }
      it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
      it { should validate_numericality_of(:total_invested).is_greater_than_or_equal_to(0) }
    end
  end
end
