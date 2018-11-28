class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :first_name, :last_name

  after_create :set_customer_data

  private

    def set_customer_data
      return if self.customer_id.present?

      begin
        customer_data = Saltedge::CustomersService.new.create(identifier: self.email)
      rescue => e
        raise e.error['error_message']
      end

      self.customer_id = customer_data['id']
      self.identifier  = customer_data['identifier']
      self.save!
    end

end
