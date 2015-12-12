class Place < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :address
  has_many :beacons
  has_many :routers
  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
  def self.find_nearby(range, lat, long)
    return Place.within(range,:origin => [lat,long]) 
  end
end
