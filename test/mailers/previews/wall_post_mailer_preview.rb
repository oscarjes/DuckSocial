# Preview all emails at http://localhost:3000/rails/mailers/wall_post_mailer
class WallPostMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/wall_post_mailer/new_post
  def new_post
    WallPostMailer.new_post(WallPost.last)
  end

end
