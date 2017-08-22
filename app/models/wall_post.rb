class WallPost < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :mentioned, class_name: "User", optional: true
  validates :body, presence: true
  has_many :likes, as: :item
  has_many :comments
  mount_uploader :image, ImageUploader

  def display_comments_count
    if comments.count == 0
      "No Comments Yet"
    elsif comments.count == 1
      "1 Comment"
    else
      "#{comments.count} Comments"
    end
  end

  def self.generate_posts(n = 5, user = nil)
    user ||= User.last
    n.times do 
      wall_post = WallPost.create(body: Faker::HowIMetYourMother.quote,
        mention_id: user.id,
        author: User.random_user
      )
      rand(3).times do
        wall_post.comments.create(
          body: Faker::HowIMetYourMother.catch_phrase,
          user: User.random_user
        )
      end      
    end
  end
end