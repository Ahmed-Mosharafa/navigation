class AddMacToBeacons < ActiveRecord::Migration
  def change
  	add_column :beacons, :mac, :string
  end
end
