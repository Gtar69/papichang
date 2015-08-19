class DropInternetOrder < ActiveRecord::Migration
  def change
    drop_table :internet_orders
  end
end
