
require 'rails_helper'

RSpec.describe Reservation, type: :model do

  context "validations" do

    it "should have check in and out dates, number of guests and paid" do
      should have_db_column(:check_in_date).of_type(:date)
      should have_db_column(:check_out_date).of_type(:date)
      should have_db_column(:number_of_guests).of_type(:integer)
      should have_db_column(:paid).of_type(:boolean)
    end

    describe "validates overlapping dates" do
      subject { Reservation.create(check_in_date: Date.new(19))}
      it 'checks overlapping dates' do
        expect(check_overlapping_dates).to be_valid
      end
    end

    # happy_path
    describe "can be created when all attributes are present" do
      When(:user) { User.create(
        first_name: "Raz",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456"
      )}
      Then { user.valid? == true }
    end

    # unhappy_path
    describe "cannot be created without a name" do
      When(:user) { User.create(email: "josh@nextacademy.com", password: "123456", password_confirmation: "123456") }
      Then { user.valid? == false }
    end

    describe "cannot be created without a email" do
      When(:user) { User.create(first_name: "Josh Teng", password: "123456", password_confirmation: "123456") }
      Then { user.valid? == false }
    end


    describe "cannot be created without a password" do
      When(:user) { User.create(first_name: "Josh Teng", email: "josh@nextacademy.com") }
      Then { user.valid? == false }
    end



    describe "should permit valid email only" do
      let(:user1) { User.create(first_name: "Tom", email: "tom@nextacademy.com", password: "123456", password_confirmation: "123456")}
      let(:user2) { User.create(first_name: "Delilah",email: "delilah.com", password: "123456", password_confirmation: "123456") }

      # happy_path
      it "sign up with valid email" do
        expect(user1).to be_valid
      end

      # unhappy_path
      it "sign up with invalid email" do
        expect(user2).to be_invalid
      end
    end
  end

end
