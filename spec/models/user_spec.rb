require 'rails_helper'

RSpec.describe User, type: :model do
  let(:email) { Faker::Internet.email }
  let(:expected_customer_id) { 1 }

  describe 'create user' do
    it 'should call after_create callback and create customer on saltedge platform' do
      expect_any_instance_of(Saltedge::CustomersService).to receive(:create).with(identifier: email)
                                                                            .and_return('id' => expected_customer_id, 'identifier' => email)

      create(:new_user, email: email)
    end

    it 'should call after_create callback and fail' do
      expect_any_instance_of(Saltedge::CustomersService).to receive(:create).with(identifier: email)
                                                                            .and_raise(SaltedgeService::Error.new(error: { 'error_message' => 'error' }))

      expect { create(:new_user, email: email) }.to raise_error('error')
    end
  end
end
