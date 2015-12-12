class Place < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :address, :map, :maplink
  has_many :beacons
  has_many :routers
  has_many :fingerprints
  has_attached_file :map, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :map, content_type: /\Aimage\/.*\Z/
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
