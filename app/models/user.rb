class User < ApplicationRecord
  validates :firstname, presence: true, length: { in: 2..20 }
  validates :lastname, presence: true, length: { in: 2..20 }
  validates :email, presence: true, uniqueness: true
  validates_email_format_of :email, :message => "needs to be a valid email address."
  has_secure_password
end