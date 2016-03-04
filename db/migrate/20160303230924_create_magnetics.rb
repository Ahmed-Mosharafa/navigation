class CreateMagnetics < ActiveRecord::Migration
  def change
    create_table :magnetics do |t|
      t.float :place_id
      t.float :x
      t.float :y
      t.float :z
      t.float :angle
      t.float :magnitude
      t.float :xcoord
      t.float :ycoord
      t.float :xsd
      t.float :ysd
      t.float :zsd
      t.float :magnitudesd

      t.timestamps
    end
  end
end
