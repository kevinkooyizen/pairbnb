class AddPhotosToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :photos, :json
  end
end
