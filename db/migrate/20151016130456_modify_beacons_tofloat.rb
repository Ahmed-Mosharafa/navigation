class Modify < ActiveRecord::Migration
  def change
    change_column :beacons, :coord_x, :float
    change_column :beacons, :coord_y, :float
    change_column :beacons, :coord_z, :float
  end
end
