class MagneticFingerPrint < ActiveRecord::Base
  attr_accessible :angle, :magnetic_id, :magnitude, :place_id, :x, :y, :z
  belongs_to :magnetic
end
