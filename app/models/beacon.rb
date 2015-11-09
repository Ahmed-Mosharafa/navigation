class Beacon < ActiveRecord::Base
  attr_accessible :coord_x, :coord_y, :coord_z, :place_id
  belongs_to :place 
  def self.fetch_metadata(placeid)
  	return Beacon.find_all_by_place_id(placeid)
  end
end
