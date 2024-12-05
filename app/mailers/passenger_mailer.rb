class PassengerMailer < ApplicationMailer
  def confirmation_email
    @name = params[:name]
    @flight = params[:flight]

    mail(to: params[:email], subject: "You have booked your ticket")
  end
end
