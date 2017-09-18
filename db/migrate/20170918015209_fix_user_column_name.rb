class FixUserColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :name, :first_name
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :phone, :integer
    add_column :users, :country, :string
    add_column :users, :birthdate, :date
    add_column :listings, :place_type, :integer
    add_column :listings, :property_type, :string
    add_column :listings, :room_number, :integer
    add_column :listings, :guest_number, :integer
    add_column :listings, :country, :string
    add_column :listings, :state, :string
    add_column :listings, :city, :string
    add_column :listings, :zipcode, :string
    add_column :listings, :price, :integer
    add_column :listings, :description, :string
  end
end
