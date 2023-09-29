class CreateFriendship < ActiveRecord::Migration[7.0]
    def change
        create_table :friendships do |t|
            t.references :user, foreign_key: true, null: false
            t.references :friend, references: :users, null: false

            t.string :gps_coordinates, default: "{}", null: false
            
            t.timestamps
        end
    
        add_foreign_key :friendships, :users, column: :friend_id
    end
end