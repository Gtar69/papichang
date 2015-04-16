class AddAasmStateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :aasm_state, :string, defaults: "order_placed"
    add_column :orders, :verified_phone, :string, defaults: "1234-567-890"
    remove_column :orders, :status

  end
end
