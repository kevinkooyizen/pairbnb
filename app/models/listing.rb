class Listing < ApplicationRecord
  belongs_to :user
  Gutentag::ActiveRecord.call self
end
