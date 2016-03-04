class Magnetic < ActiveRecord::Base
  attr_accessible :angle, :magnitude, :magnitudesd, :place_id, :x, :xcoord, :xsd, :y, :ycoord, :ysd, :z, :zsd
  has_many :magneticfingerprints
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

end