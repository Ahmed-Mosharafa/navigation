class CreateBeacons < ActiveRecord::Migration
  def change
    create_table :beacons do |t|
      t.integer :place_id
      t.integer :coord_x
      t.integer :coord_y
      t.integer :coord_z

      t.timestamps
    end
  end
end
