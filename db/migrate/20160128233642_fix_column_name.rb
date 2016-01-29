class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :wifi_finger_prints_records, :fingerprint_id, :finger_print_id
  end
end
