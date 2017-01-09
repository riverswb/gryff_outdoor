class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :secondary_address
      t.string :city
      t.string :state_abbr
      t.string :zip_code
      t.references :user
      t.timestamps null:false
    end
  end
end
