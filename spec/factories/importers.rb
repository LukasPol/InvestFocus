FactoryBot.define do
  factory :importer do
    user { create(:user) }
    file { Rack::Test::UploadedFile.new('spec/fixtures/acoes.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
  end

  trait :without_lines do
    file { Rack::Test::UploadedFile.new('spec/fixtures/without_lines.csv', 'text/csv') }
  end

  trait :others_kinds do
    file { Rack::Test::UploadedFile.new('spec/fixtures/with_others_kinds.csv', 'text/csv') }
  end
end
