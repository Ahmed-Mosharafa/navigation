class WifiFingerPrintsRecord < ActiveRecord::Base
  attr_accessible :BSSID, :RSSI, :SSID, :channel, :fingerprint_id, :mac, :place_id
  belongs_to :fingerprint
  def self.new_record(place_id, id, bssid, ssid, rssi, channel, mac)
  		#debugger
  	    WifiFingerPrintsRecord.create(:place_id => place_id, :fingerprint_id => id, :BSSID => bssid, :SSID => ssid, :RSSI => rssi, :channel => channel, :mac => mac)
  end
end
