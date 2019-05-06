class CreatePois < ActiveRecord::Migration[5.2]
  def change
    create_table :pois do |t|
      t.string :cn_name
      t.string :artwork
      t.integer :city_id

      t.timestamps
    end
    add_index :pois, :city_id
  end
end
