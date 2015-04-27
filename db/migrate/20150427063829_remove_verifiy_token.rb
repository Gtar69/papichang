class RemoveVerifiyToken < ActiveRecord::Migration
  def change
    remove_column :users, :verify_token, :string
    remove_column :orders, :order_verify, :string
  end
end
