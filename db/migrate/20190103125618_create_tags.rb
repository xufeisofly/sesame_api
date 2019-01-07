class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.integer :type, index: true, comment: '标签类型'

      t.timestamps
    end
  end
end
