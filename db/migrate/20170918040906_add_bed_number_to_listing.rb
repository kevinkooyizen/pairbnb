class AddBedNumberToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :bed_number, :integer
  end
end
