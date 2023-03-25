require 'rails_helper'

RSpec.describe Importer, type: :model do
  describe 'validates' do
    context 'presence' do
      it { should validate_presence_of(:user) }
      it { should validate_presence_of(:file) }
    end
  end

  describe 'methods' do
    it '.file_url' do
      importer = create(:importer)

      expect(importer.file_url).to include(importer.file.filename.to_s)
    end
  end
end
