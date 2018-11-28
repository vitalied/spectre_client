require 'rails_helper'

RSpec.describe ConnectionsController, type: :controller, vcr: true do

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
      context '#index' do
        it 'should have wrong api login param alert' do
          get :index

          expect(response).to be_successful
          expect(flash.alert).to match(/Customer with id: '\d*' was not found\./)
        end
      end

      context '#new' do
        it 'should redirect and have wrong api login param alert' do
          get :new

          expect(response).to redirect_to(connections_path)
          expect(flash.alert).to match(/Customer with id: '\d*' was not found\./)
        end
      end

      context '#reconnect' do
        it 'should redirect and have wrong api login param alert' do
          get :reconnect, params: { id: 1 }

          expect(response).to redirect_to(connections_path)
          expect(flash.alert).to match(/Login with id: '\d*' was not found\./)
        end
      end

      context '#destroy' do
        it 'should redirect and have wrong api login param alert' do
          delete :destroy, params: { id: 1 }

          expect(response).to redirect_to(connections_path)
          expect(flash.alert).to match(/Login with id: '\d*' was not found\./)
        end
      end
    end
  end

  describe 'logged in real user' do
    let(:user) { create(:real_user) }
    let(:connection_id) { 3415355 }
    let(:saltedge_redirect_page) { /^https:\/\/www.saltedge.com\/connect\?token=/ }

    before { sign_in(user) }

    context '#index' do
      it 'returns a success response' do
        get :index

        expect(response).to be_successful
      end

      it 'should return data' do
        get :index

        expect(response).to be_successful
        expect(assigns(:connections).size).to eq(1)

        connection = assigns(:connections)[0]

        expect(connection['id']).to eq(connection_id.to_s)
        expect(connection['status']).to eq('active')
        expect(connection['provider_name']).to eq('Fake Bank Simple')

        expect(assigns(:connections_accounts)[connection['id']]).to eq(4)
      end
    end

    context '#new' do
      it 'should redirect to saltedge conect page' do
        get :new

        expect(response).to redirect_to(saltedge_redirect_page)
      end
    end

    context '#reconnect' do
      it 'should redirect to saltedge conect page' do
        get :reconnect, params: { id: connection_id }

        expect(response).to redirect_to(saltedge_redirect_page)
      end
    end

    context '#refresh' do
      it 'should redirect to saltedge conect page' do
        get :refresh, params: { id: connection_id }

        expect(response).to redirect_to(saltedge_redirect_page)
      end
    end

    context '#destroy' do
      it 'should delete connection' do
        expect_any_instance_of(Saltedge::LoginsService).to receive(:remove)

        delete :destroy, params: { id: connection_id }

        expect(response).to redirect_to(connections_path)
        expect(flash.notice).to match(/Connection #\d* was deleted./)
      end
    end
  end

end
