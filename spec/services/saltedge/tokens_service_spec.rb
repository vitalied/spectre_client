require 'rails_helper'

RSpec.describe Saltedge::TokensService, type: :service do
  let(:service) { Saltedge::TokensService.new('app_id', 'secret') }
  let(:params) { { customer_id: 1 } }
  let(:time) { Time.now }

  describe '#new' do
    it 'takes two parameters and returns a Saltedge::TokensService object' do
      expect(service).to be_an_instance_of(Saltedge::TokensService)
    end
  end

  describe 'request' do
    let(:rest_client_args) {
      {
        method:  :post,
        url:     Saltedge::TokensService::ENDPOINT_URL,
        payload: { data: params }.to_json,
        headers: {
          'Accept':       'application/json',
          'Content-type': 'application/json',
          'Expires-at':   (time + SaltedgeService::EXPIRATION_TIME).to_i,
          'App-Id':       'app_id',
          'Secret':       'secret'
        }
      }
    }

    describe '#create' do
      it 'execute request' do
        allow(Time).to receive(:now).and_return(time)

        expect(RestClient::Request).to receive(:execute).with(rest_client_args.merge(url: "#{Saltedge::TokensService::ENDPOINT_URL}/create"))

        service.create(params)
      end
    end

    describe '#reconnect' do
      it 'execute request' do
        allow(Time).to receive(:now).and_return(time)

        expect(RestClient::Request).to receive(:execute).with(rest_client_args.merge(url: "#{Saltedge::TokensService::ENDPOINT_URL}/reconnect"))

        service.reconnect(params)
      end
    end

    describe '#refresh' do
      it 'execute request' do
        allow(Time).to receive(:now).and_return(time)

        expect(RestClient::Request).to receive(:execute).with(rest_client_args.merge(url: "#{Saltedge::TokensService::ENDPOINT_URL}/refresh"))

        service.refresh(params)
      end
    end
  end

end
