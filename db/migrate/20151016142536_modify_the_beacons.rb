class ModifyTheBeacons < ActiveRecord::Migration
  def up
    change_column :beacons, :coord_x, :float
    change_column :beacons, :coord_y, :float
    change_column :beacons, :coord_z, :float
  end

  def down
  end
end
