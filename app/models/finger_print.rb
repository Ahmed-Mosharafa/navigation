class FingerPrint < ActiveRecord::Base
  attr_accessible :BSSID, :RSSI, :SD, :SSID, :place_id, :xcoord, :ycoord, :mac
  belongs_to :place
  has_many :wififingerprintsrecords
  
   def self.to_csv
    attributes = %w{BSSID RSSI SD SSID place_id xcoord ycoord}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  def self.check_exist(parameters)
    place_fp = FingerPrint.where(:place_id => parameters[:place_id]) #divide and conqeur
    records_fp = WifiFingerPrintsRecord.where(:place_id => parameters[:place_id])
    found = place_fp.where(:BSSID => parameters[:BSSID], :xcoord => parameters[:xcoord], :ycoord=>parameters[:ycoord]) #triplet indicating a unique fp
    if (found==[])      
      created = FingerPrint.create(parameters)
      WifiFingerPrintsRecord.create(:fingerprint_id => created[:id], :BSSID => parameters[:BSSID], :SSID => parameters[:SSID], :RSSI => parameters[:RSSI], :channel => parameters[:channel], :mac => parameters[:mac])
      return created 
    else
      #debugger
      WifiFingerPrintsRecord.create(:fingerprint_id => found[0][:id], :BSSID => parameters[:BSSID], :SSID => parameters[:SSID], :RSSI => parameters[:RSSI], :channel => parameters[:channel], :mac => parameters[:mac], :place_id => parameters[:place_id])
      return calc_mean_sd(records_fp.where(:fingerprint_id => found[0][:id]), parameters, place_fp)     
    end
  end
  def self.calc_mean_sd(found, parameters, place_fp)
    found = found.all
    #mean calculation
    accum_x   = parameters[:RSSI].to_f
    len  = found.length + 1
    found.each do |element|
      accum_x = accum_x + element[:RSSI] 
    end
    mean_x = accum_x / len
    #standard deviation calculator
    len = found.length
    #debugger
    found.each do |element|   
      accum_x = accum_x + ((element[:RSSI] - mean_x) ** 2)
    end
    desired = place_fp.where(:BSSID => parameters[:BSSID], :xcoord => parameters[:xcoord], :ycoord=>parameters[:ycoord]) #triplet indicating a unique fp
    desired.update_all(:RSSI => mean_x, :SD => (accum_x / len))
    return desired[0]
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
      hash_examined = FingerPrint.validate_distance(key, value, hash_examined) 
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
  def self.KNN (measurement_hash)
    k = 3
    place_fp = FingerPrint.where(:place_id => measurement_hash["0"][:place_id]) #divide and conqeur
    nearest_coord = Hash.new() 
    measurement_hash.each do |f_id, measurment|
      records = place_fp.where(:BSSID => measurment[:BSSID]).all  
      rssi_searched = measurment[:RSSI].to_f
      distances = Hash.new(k) 
      #find an array of distances 
      records.each  do |record|
        distance = (record.RSSI - rssi_searched).abs
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
      puts nearest_coord
      #here I have weighted nearest coordinates sorted by the closest one
      coordinates   = weighted_average(nearest_coord,3)
    end
    return coordinates
  end
end

