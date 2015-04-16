class AddUserReferenceToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :user_id, :integer
    add_column :orders, :delivery_method, :string
    add_column :orders, :status, :string
  end
end
