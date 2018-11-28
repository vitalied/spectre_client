require 'rails_helper'

RSpec.describe AccountsController, type: :controller, vcr: true do

  describe 'not logged in' do
    it 'should redirect to login page' do
      get :index

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'logged in' do
    let(:user) { create(:user) }

    before { sign_in(user) }

    describe 'wrong api params' do
      it 'should have wrong api login param alert' do
        get :index

        expect(response).to be_successful
        expect(flash.alert).to match(/Customer with id: '\d*' was not found\./)
      end
    end
  end

  describe 'logged in real user' do
    let(:user) { create(:real_user) }
    let(:connection_id) { 3415355 }
    let(:account_id) { 4774998 }

    before { sign_in(user) }

    it 'returns a success response' do
      get :index

      expect(response).to be_successful
    end

    describe 'wrong api params' do
      it 'should have wrong api login param alert' do
        get :index

        expect(response).to be_successful
        expect(flash.alert).to match(/Login with id: '\d*' was not found\./)
      end
    end

    describe 'correct api params' do
      it 'should return data' do
        get :index, params: { login_id: connection_id }

        expect(response).to be_successful
        expect(assigns(:accounts).size).to eq(4)

        account = assigns(:accounts)[0]

        expect(account['id']).to eq(account_id.to_s)
        expect(account['name']).to eq('Simple account 1 MasterCard')
        expect(account['balance']).to eq(1990.11)
        expect(account['currency_code']).to eq('EUR')
        expect(account['nature']).to eq('card')

        expect(assigns(:accounts_transactions)[account['id']]).to eq(12)
      end
    end
  end

end
