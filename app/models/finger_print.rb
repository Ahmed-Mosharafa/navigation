class FingerPrint < ActiveRecord::Base
  attr_accessible :BSSID, :RSSI, :SD, :SSID, :place_id, :xcoord, :ycoord, :mac
  belongs_to :place
  has_many :wififingerprintsrecords
  
  #######################################
  #FingerPrint database creation
  #######################################

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
  
  #################################################
  #Localization #
  #################################################
  
  def self.validate_distance(key, value, hash_examined)
    keys = hash_examined.keys
    keys.each do |k|
      if (value < hash_examined[k])
        hash_examined.delete(k)
        hash_examined[key] = value
        hash_examined = FingerPrint.sort_by_value(hash_examined, 1)
        return hash_examined
      end
    end 
    return hash_examined
  end
  #order_flag: ascending => 1
  #descending =>0
  def self.sort_by_value(hash_to_sort, order_flag)
    if (order_flag == 1)
      hash_to_sort = Hash[hash_to_sort.sort_by {|k,v| v}]
    elsif (order_flag == 0)
      hash_to_sort = Hash[hash_to_sort.sort_by {|k,v| v}.reverse]
    end
    return hash_to_sort
  end 

  def self.add_to_hash(key, value, hash_examined, k)
    length = hash_examined.length 
    if (length < k)
      hash_examined[key] = value
      hash_examined = FingerPrint.sort_by_value(hash_examined, 1)
    else
      hash_examined = validate_distance(key, value, hash_examined) 
    end
    return hash_examined
  end   

  def self.append_to_hash(hash_examined, key, value)
    if (hash_examined.include?(key))
      hash_examined[key] += value
    else 
      hash_examined[key] = value
    end
    return hash_examined
  end  
  
  def self.weighted_average(hash_examined, k)
    #hash_examined =   discard_outliers(hash_examined, k)
    counter = 0.0
    xcoord_sum     = 0.0
    ycoord_sum     = 0.0
    if (hash_examined.length < k)
      k = hash_examined.length
    end
    keys   = hash_examined.keys
    for i in 0...k
      count   = hash_examined[keys[i]]
      xcoord_sum += count * keys[i][0]
      ycoord_sum += count * keys[i][1]
      counter    += count
    end 
    #if (counter ==)
    #debugger
    xcoord = xcoord_sum / counter 
    ycoord = ycoord_sum / counter
    return [xcoord,ycoord]
  end
  #def discard_outliers(nearest_coord)
  #  nearest_coord.keys
  #  nearest_coord.each do |k,v|
  #
  #  end  
  #end  
  #K hardcoded for now
  def self.KNN (measurment_hash)
    k = 3
    nearest_coord = Hash.new() 
    measurment_hash.each do |f_id, measurment|
      records = FingerPrint.where(:BSSID => measurment[:BSSID]).all  
      rssi_searched = measurment[:RSSI].to_f
      distances = Hash.new(k) 
      #find an array of distances 
      records.each  do |record|
        distance = record.RSSI - rssi_searched
        distances = FingerPrint.add_to_hash([record.xcoord, record.ycoord], distance, distances, k)
      end
      #here I have the k coordinates of the nearest neighbours along with their distances
      distances.each do |k,v|
        nearest_coord = append_to_hash(nearest_coord, k, 1)
      end  
    end 
    if (nearest_coord=={})
      coordinates = [0,0]
    else
      nearest_coord =   sort_by_value(nearest_coord,0)
      #here I have weighted nearest coordinates sorted by the closest one
      coordinates   = weighted_average(nearest_coord,k)
    end
    return coordinates
  end
end

		