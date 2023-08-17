class CreateJoinTablePostsDestaintions < ActiveRecord::Migration[7.0]
  def change
    create_join_table :posts, :destinations do |t|
      # t.index [:post_id, :destination_id]
      # t.index [:destination_id, :post_id]
    end
  end
end
