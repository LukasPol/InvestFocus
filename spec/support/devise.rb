require 'devise'

RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :request

  config.infer_spec_type_from_file_location!
end
