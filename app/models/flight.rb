class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport"
  belongs_to :arrival_airport, class_name: "Airport"

  has_many :bookings, dependent: :destroy
  has_many :passengers, through: :bookings, dependent: :destroy

  def self.year_range
    [ minimum(:start).year, maximum(:start).year ]
  end

  def self.filter_by_airports(params)
    order(:start).where(
      departure_airport_id: params[:departure_airport_id],
      arrival_airport_id: params[:arrival_airport_id]
    )
  end
end
