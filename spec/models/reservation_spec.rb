
require 'rails_helper'

RSpec.describe Reservation, type: :model do

  context "validations" do
    When(:user) { User.create(
      id: 1,
      first_name: "Raz",
      email: "raz@nextacademy.com",
      password: "123456",
      password_confirmation: "123456"
    )}

    When(:listing) { Listing.create(
      id: 1,
      user_id: 1,
      name: "Dog House",
      address: "Jalan Anjing",
      guest_number: 2)}

    When(:reservation) { Reservation.create(
      user_id: 1,
      listing_id: 1,
      number_of_guests: 2,
      check_in_date: Date.new(2017,1,30),
      check_out_date: Date.today)}

    it "should have check in and out dates, number of guests and paid" do
      should have_db_column(:check_in_date).of_type(:date)
      should have_db_column(:check_out_date).of_type(:date)
      should have_db_column(:number_of_guests).of_type(:integer)
      should have_db_column(:paid).of_type(:boolean)
    end

    describe "validates custom methods" do
      it 'checks validitiy of reservation' do
        reservation.valid?
      end
    end
  end

end
