require 'rails_helper'

RSpec.describe WallPost, type: :model do

  before do
    User.generate_users(4)
    @post_with_one_mention = WallPost.create(author: User.random_user, body: "Not important.")
    @post_with_one_mention.mentions.create(user: User.random_user)
    @post_with_three_mentions = WallPost.create(author: User.random_user, body: "Not important.")
    @post_with_three_mentions.mentions.create(user: User.random_user)
    @post_with_three_mentions.mentions.create(user: User.random_user)
    @post_with_three_mentions.mentions.create(user: User.random_user)
  end


  describe "with no mentions" do
    it "generates post with no mentions" do
      @post_with_no_mentions = WallPost.create(author: User.random_user, body: "Not important.")
      result = @post_with_no_mentions.mentions.count
      expect(result).to be(0)
    end
  end

  describe "with one mention" do
    it "generates valid wallpost and one mention" do
      result = @post_with_one_mention.mentions.count
      expect(result).to be(1)
    end
  end

  describe "with one mention" do
    it "generates valid wallpost and one mention" do
      result = @post_with_three_mentions.mentions.count
      expect(result).to be(3)
    end
  end

end
