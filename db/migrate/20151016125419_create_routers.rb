class CreateRouters < ActiveRecord::Migration
  def change
    create_table :routers do |t|
      t.string :mac
      t.float :coord_x
      t.float :coord_y
      t.float :coord_z
      t.integer :place_id

      t.timestamps
    end
  end
end
