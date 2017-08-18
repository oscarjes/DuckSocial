class WallPostMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.wall_post_mailer.new_post.subject
  #
  def new_post(wall_post)
    @user = User.find(wall_post.mention_id)
    @author = wall_post.author
    mail to: @user.email
  end
end
