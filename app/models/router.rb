class Router < ActiveRecord::Base
  attr_accessible :coord_x, :coord_y, :coord_z, :mac, :place_id
  belongs_to :place
end
