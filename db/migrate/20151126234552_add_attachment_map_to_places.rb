class AddAttachmentMapToPlaces < ActiveRecord::Migration
  def self.up
    change_table :places do |t|
      t.attachment :map
    end
  end

  def self.down
    remove_attachment :places, :map
  end
end
