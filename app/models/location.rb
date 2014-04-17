class Location < ActiveRecord::Base
  attr_accessible :address, :description, :latitude, :longitude, :title, :date
  geocoded_by :address
  before_validation :geocode, :if => :address_changed?
  validates :latitude, presence: true
  validates :longitude, presence: true
  
  scope :happening_before, lambda { |time| where("date < ?", time) }
  scope :happening_after, lambda { |time| where("date > ?", time) }
end
