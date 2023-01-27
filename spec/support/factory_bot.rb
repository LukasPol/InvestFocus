FactoryBot.use_parent_strategy = true

FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :stock_code do |n|
    "PETR#{n}"
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
