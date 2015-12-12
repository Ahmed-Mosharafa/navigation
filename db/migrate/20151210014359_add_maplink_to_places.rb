class AddMaplinkToPlaces < ActiveRecord::Migration
  def change
  	    add_column :places, :maplink, :string
  end
end
