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

  describe 'GET /new' do
    context 'when user is logged' do
      before :each do
        user = create(:user)

        sign_in(user)
      end

      it 'returns http success' do
        get new_proceed_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not logged' do
      it 'returns http success' do
        get new_proceed_path
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'POST /create' do
    context 'Success' do
      let(:stock) { create(:stock, code: 'TEST9') }

      before :each do
        user = create(:user)
        sign_in(user)

        create(:trading, user:, stock_code: stock.code)
      end


      let(:params) do
        {
          proceed: {
            amount: 10,
            value_unit: 2,
            total_value: 20,
            date: Date.yesterday,
            stock_id: stock.id
          }
        }
      end

      it 'returns http success' do
        post proceeds_path, params: params

        expect(response).to have_http_status(:created)
      end

      it 'should create Proceed' do
        expect { post proceeds_path, params: }.to(change { Proceed.count })
      end
    end

    context 'Errors' do
      let(:stock) { create(:stock, code: 'TEST9') }

      before :each do
        user = create(:user)
        sign_in(user)
      end

      let(:params) do
        {
          proceed: {
            amount: 10,
            value_unit: 2,
            total_value: 20,
            date: Date.yesterday,
            stock_id: stock.id
          }
        }
      end

      it 'not create when user dont have the stock' do
        post proceeds_path, params: params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(assigns(:proceed).errors.messages[:asset]).to include('Você não tem essa ação')
      end
    end
  end
end
