require 'rails_helper'

RSpec.describe Importation, type: :model do
  describe 'validates' do
    context 'presence' do
      it { should validate_presence_of(:user) }
      it { should validate_presence_of(:file) }
    end
  end

  describe 'methods' do
    it '.file_url' do
      importation = create(:importation)

      expect(importation.file_url).to include(importation.file.filename.to_s)
    end
  end
end
