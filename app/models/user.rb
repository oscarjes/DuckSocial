class User < ApplicationRecord
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true
  validates_email_format_of :email, :message => "Please use a vaid email address."
  has_secure_password
end