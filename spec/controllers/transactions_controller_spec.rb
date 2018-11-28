require 'rails_helper'

RSpec.describe TransactionsController, type: :controller, vcr: true do

  describe 'not logged in' do
    it 'should redirect to login page' do
      get :index

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'logged in real user' do
    let(:user) { create(:real_user) }
    let(:connection_id) { 3415355 }
    let(:account_id) { 4774998 }
    let(:transaction_id) { 765543109 }

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

      it 'should have wrong api account param alert' do
        get :index, params: { account_id: 1 }

        expect(response).to be_successful
        expect(flash.alert).to match(/Account with id: '\d*' was not found\./)
      end
    end

    describe 'correct api params' do
      it 'should return data' do
        get :index, params: { login_id: connection_id, account_id: account_id }

        expect(response).to be_successful
        expect(assigns(:transactions).size).to eq(12)

        transaction = assigns(:transactions)[0]
        expect(transaction['id']).to eq(transaction_id.to_s)
        expect(transaction['made_on']).to eq('2018-10-01')
        expect(transaction['category']).to eq('transfer')
        expect(transaction['description']).to eq('Income for Simple account 1 MasterCard')
        expect(transaction['amount']).to eq(10000.0)
        expect(transaction['currency_code']).to eq('EUR')
      end
    end
  end

end
