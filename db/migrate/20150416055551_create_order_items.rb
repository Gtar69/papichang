class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.string :product_name
      t.references :order
      t.integer :quantity
      t.integer :price
      t.timestamps
    end
  end
end
