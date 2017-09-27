class Listing < ApplicationRecord
  before_create :capitalize
  has_many :reservations
  paginates_per 4
  belongs_to :user
  # serialize :photos, Array
  mount_uploaders :photos, PhotoUploader
  Gutentag::ActiveRecord.call self
  
  validates :name, presence: true
  validates :address, presence: true
  scope :search, -> (search){ where("name ILIKE ? OR address ILIKE ? OR description ILIKE ? OR city ILIKE ? OR state ILIKE ? OR country ILIKE ? OR property_type ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") }
  scope :city, -> (city){ where("city ILIKE ?", "%#{city}%") }
  scope :bed_number, -> (bed_number){ where("bed_number >= #{bed_number}") }
  scope :room_number, -> (room_number){ where("room_number >= #{room_number}") }
  scope :initial_price, -> (initial, final){ where(price: initial..final) }
  scope :final_price, -> (final){ where("price > #{final}") }


  def capitalize
    self.attributes.each do |key, value|
      if !value.nil? && value.is_a?(String)
        value.capitalize!
      end
    end
  end
end
