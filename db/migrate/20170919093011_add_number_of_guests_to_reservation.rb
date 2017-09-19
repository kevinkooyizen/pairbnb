class AddNumberOfGuestsToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :number_of_guests, :integer
    remove_column :reservations, :date
    add_column :reservations, :check_in_date, :date
    add_column :reservations, :check_out_date, :date
  end
end
