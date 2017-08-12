class User < ApplicationRecord
  validates :firstname, presence: true, length: { in: 2..20 }
  validates :lastname, presence: true, length: { in: 2..20 }
  validates :email, presence: true, uniqueness: true
  validates :image_url, url: true
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :received_messages, foreign_key: "recipient_id", class_name: "Message"
  has_many :sent_messages, foreign_key: "sender_id", class_name: "Message"
  
  #validates_email_format_of :email, :message => "needs to be a valid email address."
  has_secure_password

  def image_url_or_default
    image_url.presence || "http://lorempixel.com/128/128/people/Fake-User/"
  end

  def self.generate_female_users(n = 25, gender = "female")
    url = "https://randomuser.me/api?results=#{n}&gender=#{gender}"
    body = HTTP.get(url).parse
    body["results"].each do |person|
      hash = {}
      hash[:firstname] = person["name"]["first"]
      hash[:lastname] = person["name"]["last"]
      hash[:email] = person["email"]
      hash[:password] = person["login"]["password"]
      hash[:image_url] = person["picture"]["large"]
      User.create! hash
    end
  end

  def add_friend(friend)
    friends << friend
  end

  def is_friend?(friend)
    friends.include?(friend)
  end
end