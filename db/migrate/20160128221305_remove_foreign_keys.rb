class RemoveForeignKeys < ActiveRecord::Migration
  def change
    remove_foreign_key "beacons", "places", name: "beacons_place_id_fk", dependent: :delete
    remove_foreign_key "finger_prints", "places", name: "finger_prints_place_id_fk", dependent: :delete
    remove_foreign_key "routers", "places", name: "routers_place_id_fk", dependent: :delete
    remove_foreign_key "wifi_finger_prints_records", "finger_prints" ,name: "wifi_finger_prints_records_fingerprint_id_fk", dependent: :delete
  end
end
