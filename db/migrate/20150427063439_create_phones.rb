class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :phone_number
      t.string :verify_code
      t.timestamps
    end
  end
end
