require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the WallPostsHelper. For example:
#
# describe WallPostsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe WallPostsHelper, type: :helper do
  before do
    User.generate_users(2)
    @post_with_one_mention = WallPost.create(author: User.random_user, body: "Not important.")
    @post_with_one_mention.mentions.create(user: User.random_user)
    @post_with_three_mentions = WallPost.create(author: User.random_user, body: "Not important.")
    @post_with_three_mentions.mentions.create(user: User.random_user)
    @post_with_three_mentions.mentions.create(user: User.random_user)
    @post_with_three_mentions.mentions.create(user: User.random_user)
  end

  describe "with one mention" do
    it "mention display as html as it should" do
      results = display_mentions(@post_with_one_mention)
      expected = "With #{@post_with_one_mention.mentions.first.user.fullname}"
      expect(results).to eq(expected)
    end
  end

  describe "with three mentions" do
    it "displays 3 mentions as html as it should" do
      results = display_mentions(@post_with_three_mentions)
      expected = "With #{@post_with_three_mentions.mentions.first.user.fullname} and 2 others"
      expect(results).to eq(expected)
    end
  end
end
