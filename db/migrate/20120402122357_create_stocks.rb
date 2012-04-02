class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :product
      t.references :store
      t.integer :quantity

      t.timestamps
    end
    add_index :stocks, :product_id
    add_index :stocks, :store_id
  end
end
