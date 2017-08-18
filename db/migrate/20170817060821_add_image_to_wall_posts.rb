class AddImageToWallPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :wall_posts, :image, :string
  end
end
