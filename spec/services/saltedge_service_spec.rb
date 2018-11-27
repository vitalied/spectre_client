require 'rails_helper'

RSpec.describe SaltedgeService, type: :service do
  let(:service) { SaltedgeService.new('app_id', 'secret') }
  let(:url) { SaltedgeService::API_BASE_URL }
  let(:method) { 'GET' }
  let(:expires_at) { (Time.now + SaltedgeService::EXPIRATION_TIME).to_i }

  describe '#new' do
    it 'takes two parameters and returns a SaltedgeService object' do
      expect(service).to be_an_instance_of(SaltedgeService)
    end
  end

  describe '#request' do
    let(:rest_client_args) {
      {
        method:  method,
        url:     url,
        payload: '',
        headers: {
          'Accept':       'application/json',
          'Content-type': 'application/json',
          'Expires-at':   expires_at,
          'App-Id':       'app_id',
          'Secret':       'secret'
        }
      }
    }

    it 'execute request' do
      expect(RestClient::Request).to receive(:execute).with(rest_client_args)

      service.request(method, url, {})
    end

    it 'execute request with error' do
      expect(RestClient::Request).to receive(:execute).with(rest_client_args).and_raise(RestClient::Exception.new(nil, 404))

      expect { service.request(method, url, {}) }.to raise_error(SaltedgeService::Error)
    end
  end

end
