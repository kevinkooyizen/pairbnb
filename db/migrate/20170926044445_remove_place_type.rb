class RemovePlaceType < ActiveRecord::Migration[5.1]
  def change
    remove_column(:listings, :place_type)
  end
end
