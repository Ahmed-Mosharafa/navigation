class CreateFingerPrints < ActiveRecord::Migration
  def change
    create_table :finger_prints do |t|
      t.integer :place_id
      t.float :xcoord
      t.float :ycoord
      t.string :BSSID
      t.string :SSID
      t.float :RSSI
      t.float :SD

      t.timestamps
    end
  end
end
