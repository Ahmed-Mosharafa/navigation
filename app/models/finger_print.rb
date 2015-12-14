class FingerPrint < ActiveRecord::Base
  attr_accessible :BSSID, :RSSI, :SD, :SSID, :place_id, :xcoord, :ycoord, :mac
  belongs_to :place
  has_many :wififingerprintsrecords

  #checks whether the finger print coming is new or saved before through the x and y coordinates  and the mac address
  #if it doesn't exist it returns 0, otherwise it returns it's id
  def self.new_fingerprint(x,y, mac)
  	same_fingerp = FingerPrint.where(:xcoord => x, :ycoord => y, :mac => mac).all
  	#debugger
  	#checks whether the record is empty or not
  	if (FingerPrint.fetch_last_id !=0)
  		#checks whether there are records with the same fingerprint or not
  		last    = WifiFingerPrintsRecord.last
	  	if (same_fingerp == [])
	  		#pass the records to the calc mean_sd
	  		#records is an array of fingerprints in WifiFingerPrintRecord with the same x,y,mac
	  		records = WifiFingerPrintsRecord.where(:fingerprint_id => last[:fingerprint_id], :mac => last[:mac]).all 
	  		FingerPrint.calculate_mean_sd(records, last[:fingerprint_id])
	  		return 0
	  	else
	  		if (last[:mac] != mac)
	  			FingerPrint.calculate_mean_sd(WifiFingerPrintsRecord.where(:fingerprint_id => last[:fingerprint_id], :mac => last[:mac]).all, last[:fingerprint_id])
  			end
	  		#debugger
 	  		return same_fingerp[0].id
	  	end
	else
		return 0 
	end 
  end
  #calculates the standard deviation of the records with the same coordinates(of the same place)
  def self.calc_standard_deviation(mean, records)
  	#debugger
  	accum  = 0.0
  	len = records.length
  	records.each do |element|		
  		accum = accum + ((element[:RSSI] - mean) ** 2)
  	end
  	sd = (accum/len) ** 0.5
  	return sd
  end
  #calculates the mean of the records with the same coordinates(of the same place)
  def self.calc_mean(records)
  	accum   = 0.0
  	len  = records.length
  	records.each do |element|
  		accum = accum + element[:RSSI] 
  	end
  	mean = accum / len
  	return mean
  end
  #calls mean and standard deviation to save the mean RSSI and the SD to the record if you finished reading the fingerprints for this coordinates
  #with the same mac address(for the same router)
  #params: fingerprint_records: an array of the records with the same xcoord, ycoord, mac
  def self.calculate_mean_sd(fingerprint_records, last_id)
	mean_RSSI = FingerPrint.calc_mean(fingerprint_records)
  	sd_rssi   = FingerPrint.calc_standard_deviation(mean_RSSI, fingerprint_records)
  	last = FingerPrint.find_by_id(last_id)
	last.update_attributes(:RSSI => mean_RSSI, :SD => sd_rssi)
  end

  def self.fetch_last_id()
  	fp = FingerPrint.last
  	if (fp == nil)
  		return 0
  	else
	  	id = fp[:id]
	end
  end
end

		