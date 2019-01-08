class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.integer :start_id, index: true
      t.integer :end_id, index: true
      t.string :train_no
      t.string :start_time
      t.string :end_time
      t.string :duration

      t.timestamps
    end
  end
end
