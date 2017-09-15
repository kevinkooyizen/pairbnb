class Listing < ApplicationRecord
  belongs_to :user
  Gutentag::ActiveRecord.call self
  validates :name, presence: true
  validates :address, presence: true
end
