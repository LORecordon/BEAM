class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.belongs_to :trip
      t.references :author, references: :users, null: false, type: :int

      t.timestamps
    end
    rename_column :posts, :author_id, :author
  end
end
