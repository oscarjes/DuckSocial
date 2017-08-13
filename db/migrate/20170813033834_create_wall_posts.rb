class CreateWallPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :wall_posts do |t|
      t.text :body
      t.integer :author_id
      t.integer :mention_id

      t.timestamps
    end
  end
end
