class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :place
      t.string :location
      t.string :country
      t.string :postcode
      t.string :map
      t.references :store

      t.timestamps
    end
  end
end
