class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
    @flight = @booking.flight
  end

  def new
    @flight = Flight.find(params[:flight_id])

    @booking = Booking.new

    number_of_passengers = params[:number_of_passengers].to_i

    number_of_passengers.times do
      @booking.passengers.build
    end
  end

  def create
    @booking = Booking.new(booking_params)
    @flight = @booking.flight

    if @booking.save
      @booking.passengers.each do |passenger|
        PassengerMailer.with(name: passenger.name, email: passenger.email, flight: @flight).confirmation_email.deliver_later
      end

      redirect_to @booking, notice: "Booking created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def booking_params
      params.require(:booking).permit(:flight_id, :number_of_passengers, passengers_attributes: [ :name, :email ])
    end
end
