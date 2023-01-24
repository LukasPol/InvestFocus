FactoryBot.define do
  factory :asset do
    amount { 1 }
    average_price { 1.5 }
    total_invested { 1.5 }
    user { create(:user) }
    stock { create(:stock) }
  end
end
