class AddPlaceIdToWifiFingerPrintsRecords < ActiveRecord::Migration
  def change
  	add_column :wifi_finger_prints_records, :place_id, :float
  end
end
