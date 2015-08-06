class CreateProductAttributes < ActiveRecord::Migration
  def change
    create_table :product_attributes do |t|
    	t.string  :name
    	t.integer :price
    	t.integer :product_id
    end
  end
end