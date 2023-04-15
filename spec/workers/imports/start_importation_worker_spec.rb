require 'rails_helper'

RSpec.describe Imports::StartImportationWorker, type: :worker do
  describe 'options sidekiq' do
    it { is_expected.to be_processed_in(:highest) }
    it { is_expected.to be_retryable(4) }
  end

  describe '.perform' do
    let(:importation) { create(:importation) }

    it 'call the method to create job and send mail' do
      expect do
        described_class.perform_async(importation.id)
      end.to change(described_class.jobs, :size).by(1)
    end
  end
end
