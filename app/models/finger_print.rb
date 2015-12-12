class FingerPrint < ActiveRecord::Base
  attr_accessible :BSSID, :MRSSI, :SD, :SSID, :place_id, :xcoord, :ycoord
end
