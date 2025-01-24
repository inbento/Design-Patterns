class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.references :client, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.date :check_in_date
      t.date :departure_date

      t.timestamps
    end
  end
end
