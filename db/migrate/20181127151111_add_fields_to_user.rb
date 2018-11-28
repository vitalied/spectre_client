class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :customer_id, :integer
    add_column :users, :identifier, :string
  end
end
