class WifiFingerPrintsRecord < ActiveRecord::Base
  attr_accessible :BSSID, :RSSI, :SSID, :channel, :fingerprint_id, :mac, :place_id
  belongs_to :finger_print
  def self.new_record(place_id, id, bssid, ssid, rssi, channel, mac)
  		#debugger
  	    WifiFingerPrintsRecord.create(:place_id => place_id, :fingerprint_id => id, :BSSID => bssid, :SSID => ssid, :RSSI => rssi, :channel => channel, :mac => mac)
  end 
  def self.to_csv
    attributes = %w{BSSID RSSI SD SSID place_id xcoord ycoord}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end
end
