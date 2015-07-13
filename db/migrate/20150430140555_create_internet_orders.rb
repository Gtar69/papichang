class CreateInternetOrders < ActiveRecord::Migration
  def change
    create_table :internet_orders do |t|

      t.timestamps
    end
  end
end
