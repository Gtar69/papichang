class CreateWaitingqueues < ActiveRecord::Migration
  def change
    create_table :waitingqueues, :id => false do |t|
      t.integer :order_id
      t.timestamps
    end
  end
end