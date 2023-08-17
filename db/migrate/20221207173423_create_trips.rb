class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.belongs_to :author, references: :users, null: false, type: :int

      t.timestamps
    end
    rename_column :trips, :author_id, :author
  end
end
