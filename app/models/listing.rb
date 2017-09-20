class Listing < ApplicationRecord
  has_many :reservations
  paginates_per 4
  belongs_to :user
  # serialize :photos, Array
  mount_uploaders :photos, PhotoUploader
  Gutentag::ActiveRecord.call self
  validates :name, presence: true
  validates :address, presence: true

  def self.search(search)
    where("name ILIKE ? OR address ILIKE ? OR description ILIKE ? OR city ILIKE ? OR state ILIKE ? OR country ILIKE ? OR property_type ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
