require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
  end

  describe '.name' do
    it 'return name correct' do
      user = create(:user, email: 'lukas@test.com')

      expect(user.name).to eq('Lukas')
    end
  end
end
