FactoryBot.define do
  factory :stock do
    name { 'Petrobrás' }
    code { generate(:stock_code) }
  end
end
