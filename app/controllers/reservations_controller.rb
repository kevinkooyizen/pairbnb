class ReservationsController < ApplicationController
  def new
  end

  def create
    reservation = Reservation.new(reservation_params)
    byebug
    if reservation.save
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
  end

  def reservation_params
    params.require(:reservation).permit(:check_in_date, :user_id, :check_out_date, :number_of_guests, :listing_id)
  end
end
