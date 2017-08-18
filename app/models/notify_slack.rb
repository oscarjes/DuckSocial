class NotifySlack < ApplicationRecord
  def initialize
    @notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"]
  end

  def notify_new_wall_post(post)
    @notifier.ping(post.body,
      username: post.author.fullname,
      icon_url: post.author.avatar.url,
      attachments: [image_url: post.image.url, title: post.body]
    )
  end
end
