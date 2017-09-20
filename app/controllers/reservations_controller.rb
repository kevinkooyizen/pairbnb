class ReservationsController < ApplicationController
  def create
    @listing = Listing.find(params[:listing_id])
    @reservation = current_user.reservations.new(reservation_params)
    @reservation.listing = @listing
    if @reservation.save
      redirect_to current_user
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
end
