class CreateRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :rooms do |t|
      t.string :type
      t.integer :capacity
      t.decimal :price

      t.timestamps
    end
  end
end
