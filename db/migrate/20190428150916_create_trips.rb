class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.integer :start_city_id, comment: '出发城市 id'
      t.integer :end_city_id, comment: '到达城市 id'
      t.integer :duration_min, comment: '花费时间，单位 min'

      t.timestamps
    end
    add_index :trips, :duration_min
    add_index :trips, [:start_city_id, :end_city_id], unique: true
  end
end
