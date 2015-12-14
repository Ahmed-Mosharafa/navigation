class WifiFingerPrintsRecord < ActiveRecord::Base
  attr_accessible :BSSID, :RSSI, :SSID, :channel, :fingerprint_id, :mac
  belongs_to :fingerprint
  def self.new_record(available, bssid, ssid, rssi, channel, mac)
  		#debugger
  	    WifiFingerPrintsRecord.create(:fingerprint_id => available, :BSSID => bssid, :SSID => ssid, :RSSI => rssi, :channel => channel, :mac => mac)
  end
end
