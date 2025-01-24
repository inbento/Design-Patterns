class CreateServices < ActiveRecord::Migration[8.0]
  def change
    create_table :services do |t|
      t.string :title
      t.decimal :price

      t.timestamps
    end
  end
end
