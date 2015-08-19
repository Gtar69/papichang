class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string  :zip_code
      t.string  :city
      t.string  :district_with_street
      t.string  :lane
      t.string  :alley
      t.string  :street_number
      t.string  :floor
      t.string  :note
      t.timestamps
    end
  end
end
