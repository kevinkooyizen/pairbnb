class Listing < ApplicationRecord
  paginates_per 4
  belongs_to :user
  Gutentag::ActiveRecord.call self
  validates :name, presence: true
  validates :address, presence: true
end
