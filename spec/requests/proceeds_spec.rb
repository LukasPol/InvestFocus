require 'rails_helper'

RSpec.describe '/proceeds', type: :request do
  describe 'GET /index' do
    context 'when user is logged' do
      before :each do
        user = create(:user)
        create(:trading, user:)
        create_list(:proceed, 3, user:)

        sign_in(user)
      end

      it 'returns http success' do
        get proceeds_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not logged' do
      it 'returns http success' do
        get proceeds_path
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
