class Magnetic < ActiveRecord::Base
  attr_accessible :angle, :magnitude, :magnitudesd, :place_id, :x, :xcoord, :xsd, :y, :ycoord, :ysd, :z, :zsd
  has_many :magneticfingerprints
  def self.to_csv
    attributes = %w{angle magnitude magnitudesd place_id x y z xcoord ycoord xsd ysd zsd}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end
  ###########################
  ##Fingerprints allocation##
  ###########################
  def self.check_exist(parameters)
  	place_fp = Magnetic.where(:place_id => parameters[:place_id]) #divide and conqeur
  	records_fp = MagneticFingerPrint.where(:place_id => parameters[:place_id])
  	found = place_fp.where(:angle => parameters[:angle], :xcoord => parameters[:xcoord], :ycoord=>parameters[:ycoord]) #triplet indicating a unique fp
  	
  	if (found==[])
  		
  		created = Magnetic.create(parameters)
  		MagneticFingerPrint.create(:magnetic_id => created[:id], :angle => parameters[:angle], :magnitude => parameters[:magnitude], :place_id => parameters[:place_id], :x => parameters[:x], :y => parameters[:y], :z => parameters[:z])
  		return created 
  	else
  		MagneticFingerPrint.create(:magnetic_id => place_fp.where(:angle => parameters[:angle], :xcoord => parameters[:xcoord], :ycoord=>parameters[:ycoord])[0][:id], :angle => parameters[:angle], :magnitude => parameters[:magnitude], :place_id => parameters[:place_id], :x => parameters[:x], :y => parameters[:y], :z => parameters[:z])
  		return calc_mean_sd(records_fp.where(:magnetic_id => found[0][:id]), parameters, place_fp)
  		
  	end
  end	
  def self.calc_mean_sd(found, parameters, place_fp)
  	found = found.all
  	#mean calculation
  	accum_x   = parameters[:x].to_f
  	accum_y   = parameters[:y].to_f
  	accum_z   = parameters[:z].to_f
  	accum_mag = parameters[:magnitude].to_f
    len  = found.length + 1
    found.each do |element|
      accum_x = accum_x + element[:x] 
      accum_y = accum_y + element[:y]
      accum_z = accum_z + element[:z]
      accum_mag = accum_mag +element[:magnitude]
    end
    mean_x = accum_x / len
    mean_y = accum_y / len
    mean_z = accum_z / len
    mean_mag = accum_mag / len
    #standard deviation calculator
    accum_x   = parameters[:x].to_f
  	accum_y   = parameters[:y].to_f
  	accum_z   = parameters[:z].to_f
  	accum_mag = parameters[:magnitude].to_f
    len = found.length
    found.each do |element|   
      accum_x = accum_x + ((element[:x] - mean_x) ** 2)
      accum_y = accum_y + ((element[:y] - mean_y) ** 2)
      accum_z = accum_z + ((element[:z] - mean_z) ** 2)
      accum_mag = accum_mag + ((element[:magnitude] - mean_mag) ** 2)
    end
    desired = place_fp.where(:angle => parameters[:angle], :xcoord => parameters[:xcoord], :ycoord=>parameters[:ycoord])
    desired.update_all(:x => mean_x, :y => mean_y, :z => mean_z, :magnitude => mean_mag, :xsd => ((accum_x/len) ** 0.5), :ysd => ((accum_y/len) ** 0.5) , :zsd => ((accum_z/len) ** 0.5), :magnitudesd => ((accum_mag/len) ** 0.5) )
    return desired
  end
  ###########################
  ##Localization##
  ###########################
  #TODO grab generic functions to a module and import the module for both WIFI and magnetic
  def self.validate_distance(key, value, hash_examined)
    keys = hash_examined.keys
    keys.each do |k|
      if (value < hash_examined[k])
        hash_examined.delete(k)
        hash_examined[key] = value
        hash_examined = Magnetic.sort_by_value(hash_examined, 1)
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
      hash_examined = Magnetic.sort_by_value(hash_examined, 1)
    else
      hash_examined = Magnetic.validate_distance(key, value, hash_examined) 
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
  #K nearest neighbour 
  def self.KNN(measurement_hash)
  	k = 3
  	#Get all place's fingerprints
  	#debugger
  	place_fp = Magnetic.where(:place_id => measurement_hash["0"][:place_id]) #divide and conqeur
  	#X Y Z together is our feature vector
  	#measurement hash contains a number of measurements where we perform the operation multiple times
  	#to get better accuracy
	nearest_coord = Hash.new() 
	measurement_hash.each do |f_id, measurement|  	
		distances = Hash.new(k) 
	  	place_fp.each do |record|
	  		#euclidean distance 
	  		distance = Measurable.euclidean([ record[:x], record[:y], record[:z] ], [ measurement[:x].to_f, measurement[:y].to_f, measurement[:z].to_f ])
        	distances = Magnetic.add_to_hash([record.xcoord, record.ycoord], distance, distances, k)
	  	end	
	  	#process of giving weights to distances
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