class CreateWifiFingerPrintsRecords < ActiveRecord::Migration
  def change
    create_table :wifi_finger_prints_records do |t|
      t.integer :fingerprint_id
      t.string :BSSID
      t.string :SSID
      t.integer :RSSI
      t.integer :channel

      t.timestamps
    end
  end
end
