class CreateCityTagRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :city_tag_relations do |t|
      t.integer :city_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :city_tag_relations, :city_id
    add_index :city_tag_relations, :tag_id
  end
end
