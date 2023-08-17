class AddPublicToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :public, :boolean, default: true
  end
end
