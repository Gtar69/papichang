class CreateWaitingqueues < ActiveRecord::Migration
  def change
    create_table :waiting_queues, :id => false do |t|
      t.integer :order_id
      #t.timestamps
    end
  end
end