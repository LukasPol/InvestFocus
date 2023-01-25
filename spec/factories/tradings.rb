FactoryBot.define do
  factory :trading do
    amount { 2 }
    value_unit { 2.5 }
    total_value { 2.5 }
    kind { :buy }
    date { Date.yesterday }
    asset { create(:asset) }
    stock { create(:stock) }
    user { create(:user) }
  end
end
