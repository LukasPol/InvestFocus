FactoryBot.define do
  factory :proceed do
    amount { 1 }
    kind { :dividends }
    date { Date.yesterday }
    total_value { 1.5 }
    value_unit { 1.5 }
    user { create(:user) }
    stock_code { 'CODE99' }
  end

  trait :dividends do
    kind { :dividends }
  end

  trait :jcp do
    kind { :jcp }
  end
end
