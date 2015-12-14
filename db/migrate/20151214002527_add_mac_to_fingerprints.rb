class AddMacToFingerprints < ActiveRecord::Migration
  def change
	add_column :finger_prints, :mac, :string
  end
end
