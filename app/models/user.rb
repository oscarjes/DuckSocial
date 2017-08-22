class User < ApplicationRecord
  validates :firstname, presence: true, length: { in: 2..20 }
  validates :lastname, presence: true, length: { in: 2..20 }
  validates :email, presence: true, uniqueness: true
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy
  has_many :received_messages, foreign_key: "recipient_id", class_name: "Message", dependent: :destroy
  has_many :sent_messages, foreign_key: "sender_id", class_name: "Message", dependent: :destroy
  has_many :wall_posts, foreign_key: "author_id", class_name: "WallPost", dependent: :destroy
  has_many :wall_mentions, foreign_key: "mention_id", class_name: "WallPost", dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :walls,  dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  
  #validates_email_format_of :email, :message => "needs to be a valid email address."
  has_secure_password

  def image_url_or_default
    avatar.url || image_url.presence || "http://lorempixel.com/128/128/people/Fake-User/"
  end

  def self.generate_users(n = 25, gender = "female")
    url = "https://randomuser.me/api?results=#{n}&gender=#{gender}"
    body = HTTP.get(url).parse
    body["results"].each do |person|
      hash = {}
      hash[:firstname] = person["name"]["first"]
      hash[:lastname] = person["name"]["last"]
      hash[:email] = person["email"]
      hash[:password] = person["login"]["password"]
      hash[:remote_avatar_url] = person["picture"]["large"]
      User.create! hash
    end
  end

  def add_friend(friend)
    friends << friend
  end

  def is_friend?(friend)
    friends.include?(friend)
  end

  def added_as_friend_count(user)
    added_list = friendships.find_by(friend_id: user.id)
    added_list.count
  end

  def recipients
    friends.map{|e| [e.fullname, e.id]}
  end

  def fullname
    fullname = firstname.titleize + " " + lastname.titleize
    fullname
  end

  def self.mentioned_name(wall_post)
    user = User.find(wall_post.mention_id)
    user.fullname
  end

  def likes_toggle!(item)
    likes.where(item: item).first ? likes.where(item: item).first.destroy : likes.create(item: item)
  end

  def self.random_user
    random_index = rand(User.count)
    User.offset(random_index).first
  end

end