class ReservationMailer < ApplicationMailer
  def booking_email(customer, host, reservation_id)
    @customer = customer
    @host = host
    @url = "http://localhost:3000/users/#{@customer.id}"
    @reservation = Reservation.find(reservation_id)
    mail(to: @customer.email, subject: 'Welcome to My Awesome Site')
  end
end