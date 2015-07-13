class AddAttributesToInternetOrders < ActiveRecord::Migration
  def change
    add_column :internet_orders, :aasm_state, :string, defaults: "order_placed"
    add_column :internet_orders, :delivery_method, :string
  end
end
