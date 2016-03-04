class CreateMagneticFingerPrints < ActiveRecord::Migration
  def change
    create_table :magnetic_finger_prints do |t|
      t.float :place_id
      t.float :x
      t.float :y
      t.float :z
      t.float :angle
      t.float :magnitude
      t.integer :magnetic_id

      t.timestamps
    end
  end
end
