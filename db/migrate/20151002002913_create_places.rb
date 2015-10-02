class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.integer :latitude
      t.integer :longitude
      t.integer :range

      t.timestamps
    end
  end
end
