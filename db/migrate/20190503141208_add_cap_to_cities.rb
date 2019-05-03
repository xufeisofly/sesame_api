class AddCapToCities < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :cap, :string
    add_index :cities, :cap
    add_column :cities, :py_cap, :string
    add_index :cities, :py_cap
  end
end
