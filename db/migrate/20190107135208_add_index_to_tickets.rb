class AddIndexToTickets < ActiveRecord::Migration[5.2]
  def change
    add_index :tickets, [:start_id, :end_id, :train_no], unique: true
  end
end
