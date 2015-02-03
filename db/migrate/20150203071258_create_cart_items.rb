class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.references :user
      t.references :product

      t.timestamps
    end
  end
end
