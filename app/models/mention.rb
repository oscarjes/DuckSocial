class Mention < ApplicationRecord
  belongs_to :user
  belongs_to :wall_post
end
