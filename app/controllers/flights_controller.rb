class FlightsController < ApplicationController
  def index
    @airports = Airport.pluck(:code, :id)
    @start_year, @end_year = Flight.year_range

    @flights = Flight.filter_by_airports(params)

    if params["[date(1i)]"].present?
      @flights = @flights.select do |flight|
        flight.start.year == params["[date(1i)]"].to_i
      end
    end

    if params["[date(2i)]"].present?
      @flights = @flights.select do |flight|
        flight.start.month == params["[date(2i)]"].to_i
      end
    end

    if params["[date(3i)]"].present?
      @flights = @flights.select do |flight|
        flight.start.day == params["[date(3i)]"].to_i
      end
    end
  end
end
