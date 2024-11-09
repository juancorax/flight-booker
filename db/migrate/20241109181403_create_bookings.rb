class CreateBookings < ActiveRecord::Migration[7.2]
  def change
    create_table :bookings do |t|
      t.belongs_to :flight, foreign_key: true

      t.timestamps
    end
  end
end
