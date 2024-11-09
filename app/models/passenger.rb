class Passenger < ApplicationRecord
  has_and_belongs_to_many :bookings, dependent: :destroy
  has_many :flights, through: :bookings, dependent: :destroy
end
