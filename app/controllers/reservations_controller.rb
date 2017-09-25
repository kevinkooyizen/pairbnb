class ReservationsController < ApplicationController

  def new
    @client_token = Braintree::ClientToken.generate
  end

  def create
    date = params[:reservation][:check_in_date].partition(' to ')
    params[:reservation][:check_in_date] = date[0]
    params[:reservation][:check_out_date] = date[2]
    @listing = Listing.find(params[:listing_id])
    @host = User.find(@listing.user_id)
    @reservation = current_user.reservations.new(reservation_params)
    @reservation.listing = @listing
    if @reservation.save
      ReservationMailer.booking_email(current_user, @host, @reservation.id).deliver_later
      redirect_to new_reservation_path(reservation_id: @reservation.id)
    else
      @errors = @reservation.errors.full_messages
      render "listings/show"
    end
  end

  def destroy
  end

  def reservation_params
    params.require(:reservation).permit(:check_in_date, :user_id, :check_out_date, :number_of_guests, :listing_id)
  end

  def checkout
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    result = Braintree::Transaction.sale(
     :amount => "10.00", #this is currently hardcoded
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )

    if result.success?
      @reservation = Reservation.find(params[:checkout_form][:reservation_id])
      @reservation.update(paid: true)
      redirect_to user_path(current_user), :flash => { :success => "Transaction successful!" }
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end 
  end
end
