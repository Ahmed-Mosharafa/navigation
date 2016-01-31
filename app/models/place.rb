class Place < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :address, :map, :maplink
  has_many :beacons
  has_many :routers
  has_many :fingerprints
  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
  def self.find_nearby(range, lat, long)
    return Place.within(range,:origin => [lat,long]) 
  end
  def self.get_map_link(id)
    return Place.find(1)[:maplink]
  end
end
