class AddPoiNumToCities < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :poi_num, :integer, default: 0
    add_index :cities, :poi_num
    add_column :cities, :default_poi_id, :integer
    add_index :cities, :default_poi_id
  end
end
