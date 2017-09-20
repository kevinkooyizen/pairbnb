class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validate :check_out_after_check_in
  validate :check_in_date_cannot_be_in_the_past
  validate :check_overlapping_dates
  validate :check_max_guests

  def check_in_date_cannot_be_in_the_past
    erors.add(:check_in_date, "can't be in the past") if
      !check_in_date.blank? and check_in_date < Date.today
  end

  def check_out_after_check_in
    errors.add(:check_out_date, "can't be before check in date") if
      check_out_date < check_in_date
  end

  def check_overlapping_dates
    listing.reservations.each do |old_booking|
      if overlap?(self, old_booking)
        return errors.add(:check_overlapping_dates, "The booking dates conflit with existing bookings")
      end
    end
  end

  def check_max_guests
    max_guests = listing.guest_number
    return if number_of_guests < max_guests
    errors.add(:max_guests, "Max guests number exceeded")
  end

  def overlap?(x,y)
    (x.check_in_date - y.check_out_date) * (y.check_in_date - x.check_out_date) > 0
  end

  def total_price
    price = listing.price
    num_dates = (check_in_date..check_out_date).to_a.length
    return price * num_dates
  end

end
