class AddPinyinToCities < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :pinyin, :string
    add_index :cities, :pinyin
  end
end
