class ReservationsController < ApplicationController
  def create
    date = params[:reservation][:check_in_date].partition(' to ')
    params[:reservation][:check_in_date] = date[0]
    params[:reservation][:check_out_date] = date[2]
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
