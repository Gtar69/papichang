class AddAttributesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :quantity, :integer, :default => 1
    add_column :products, :price, :float
    add_column :products, :url, :string
  end
end
