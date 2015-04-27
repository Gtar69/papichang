class AddMatchMethodToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :match_method, :string
  end
end
