class AddFriendshipTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :friendship_token, :string
  end
end
