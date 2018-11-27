require 'rails_helper'

RSpec.describe Saltedge::AccountsService, type: :service do
  let(:service) { Saltedge::AccountsService.new('app_id', 'secret') }
  let(:params) { { login_id: 1 } }
  let(:time) { Time.now }

  describe '#new' do
    it 'takes two parameters and returns a Saltedge::AccountsService object' do
      expect(service).to be_an_instance_of(Saltedge::AccountsService)
    end
  end

  describe 'request' do
    let(:rest_client_args) {
      {
        method:  :get,
        url:     Saltedge::AccountsService::ENDPOINT_URL,
        payload: params.to_json,
        headers: {
          'Accept':       'application/json',
          'Content-type': 'application/json',
          'Expires-at':   (time + SaltedgeService::EXPIRATION_TIME).to_i,
          'App-Id':       'app_id',
          'Secret':       'secret'
        }
      }
    }

    describe '#list' do
      it 'execute request' do
        allow(Time).to receive(:now).and_return(time)

        expect(RestClient::Request).to receive(:execute).with(rest_client_args)

        service.list(params)
      end
    end
  end

end
