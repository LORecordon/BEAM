class AddLatitudeToDestination < ActiveRecord::Migration[7.0]
  def change
    add_column :destinations, :latitude, :float
  end
end
