class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name, index: true
      t.string :code, index: true

      t.timestamps
    end
  end
end
