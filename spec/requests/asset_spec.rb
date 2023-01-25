require 'rails_helper'

RSpec.describe 'Asset', type: :request do
  describe 'GET /index' do
    context 'when user is logged' do
      before :each do
        user = create(:user)
        create_list(:asset, 3, user:)

        sign_in(user)
      end

      it 'returns http success' do
        get assets_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not logged' do
      it 'returns http success' do
        get assets_path
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
