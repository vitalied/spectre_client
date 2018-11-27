require 'rails_helper'

RSpec.describe Saltedge::LoginsService, type: :service do
  let(:service) { Saltedge::LoginsService.new('app_id', 'secret') }
  let(:params) { {} }
  let(:time) { Time.now }

  describe '#new' do
    it 'takes two parameters and returns a Saltedge::LoginsService object' do
      expect(service).to be_an_instance_of(Saltedge::LoginsService)
    end
  end

  describe 'request' do
    let(:rest_client_args) {
      {
        method:  :get,
        url:     Saltedge::LoginsService::ENDPOINT_URL,
        payload: '',
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

    describe '#remove' do
      it 'execute request' do
        allow(Time).to receive(:now).and_return(time)

        expect(RestClient::Request).to receive(:execute).with(rest_client_args.merge(method: :delete, url: "#{Saltedge::LoginsService::ENDPOINT_URL}/1"))

        service.remove(id: 1)
      end
    end
  end

end
