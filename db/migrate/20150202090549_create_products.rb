class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :quantity, default: 0
      t.integer :price, default: 0
      t.timestamps
    end
  end
end
