class WifiFingerPrintsRecord < ActiveRecord::Base
  attr_accessible :BSSID, :RSSI, :SSID, :channel, :fingerprint_id
end
