class AddIndexToCities < ActiveRecord::Migration[5.2]
  def change
    add_index :city_tag_relations, [:city_id, :tag_id], unique: true
  end
end
