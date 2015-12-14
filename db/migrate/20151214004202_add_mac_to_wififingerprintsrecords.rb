class AddMacToWififingerprintsrecords < ActiveRecord::Migration
  def change
  	add_column :wifi_finger_prints_records, :mac, :string
  end
end
