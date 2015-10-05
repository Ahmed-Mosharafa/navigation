class RemoveRangeFromPlaces < ActiveRecord::Migration
  def up
    remove_column :places, :range
  end

  def down
    add_column :places, :range, :integer
  end
end
