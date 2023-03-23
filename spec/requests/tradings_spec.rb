require 'rails_helper'

RSpec.describe 'Tradings', type: :request do
  describe 'GET /index' do
    context 'when user is logged' do
      before :each do
        user = create(:user)
        create_list(:trading, 3, user:)

        sign_in(user)
      end

      it 'returns http success' do
        get tradings_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not logged' do
      it 'returns http success' do
        get tradings_path
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'GET /new' do
    context 'when user is logged' do
      before :each do
        user = create(:user)
        sign_in(user)
      end

      it 'returns http success' do
        get new_trading_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not logged' do
      it 'returns http success' do
        get new_trading_path
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'POST /create' do
    context 'Success' do
      before :each do
        user = create(:user)
        sign_in(user)
      end

      let(:params) do
        {
          trading: {
            amount: 10,
            value_unit: 2,
            total_value: 20,
            operation_cost: 1,
            date: Date.yesterday,
            stock_code: 'TEST9'
          }
        }
      end

      it 'returns http success' do
        post(tradings_path, params:)

        expect(response).to have_http_status(:created)
      end

      it 'should create Trading' do
        expect { post tradings_path, params: }.to(change { Trading.count })
      end

      it 'should create new Stock' do
        expect { post tradings_path, params: }.to(change { Stock.count })
      end

      it 'should create new Asset user' do
        expect { post tradings_path, params: }.to(change { Asset.count })
      end
    end
  end
end
