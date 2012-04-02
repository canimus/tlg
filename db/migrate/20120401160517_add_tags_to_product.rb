class AddTagsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :tags, :text
    add_column :products, :properties, :text
  end
end
