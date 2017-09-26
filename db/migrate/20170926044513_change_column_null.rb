class ChangeColumnNull < ActiveRecord::Migration[5.1]
  def up
    change_column_null :listings, :property_type, null: true
    change_column_null :listings, :room_number, null: true
    change_column_null :listings, :guest_number, null: true
    change_column_null :listings, :country, null: true
    change_column_null :listings, :state, null: true
    change_column_null :listings, :city, null: true
    change_column_null :listings, :zipcode, null: true
    change_column_null :listings, :price, null: true
    change_column_null :listings, :description, null: true
    change_column_null :listings, :bed_number, null: true
    change_column_null :listings, :photos, null: true
  end

  def down
    change_column_null :listings, :property_type, null: false
    change_column_null :listings, :room_number, null: false
    change_column_null :listings, :guest_number, null: false
    change_column_null :listings, :country, null: false
    change_column_null :listings, :state, null: false
    change_column_null :listings, :city, null: false
    change_column_null :listings, :zipcode, null: false
    change_column_null :listings, :price, null: false
    change_column_null :listings, :description, null: false
    change_column_null :listings, :bed_number, null: false
    change_column_null :listings, :photos, null: false
  end

end
