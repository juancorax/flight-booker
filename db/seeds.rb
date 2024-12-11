require 'faker'

airport_codes = []

10.times do
  code = ""

  loop do
    code = Faker::Travel::Airport.iata(size: 'large', region: 'united_states')

    break unless airport_codes.include?(code)
  end

  airport_codes << code
end

airport_codes.each do |airport_code|
  Airport.find_or_create_by!(code: airport_code)
end

airport_ids = Airport.pluck(:id)

100.times do
  departure_airport_id = airport_ids.sample

  arrival_airport_id = (airport_ids - [ departure_airport_id ]).sample

  start = Faker::Time.forward()

  duration = rand(60..1200)

  Flight.find_or_create_by!(
    departure_airport_id: departure_airport_id,
    arrival_airport_id: arrival_airport_id,
    start: start,
    duration: duration,
  )
end
