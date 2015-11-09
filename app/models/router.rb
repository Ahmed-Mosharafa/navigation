class Router < ActiveRecord::Base
  attr_accessible :coord_x, :coord_y, :coord_z, :mac, :place_id
  belongs_to :place
  def self.fetch_metadata(placeid)
  	return Router.find_all_by_place_id(placeid)
  end
end
