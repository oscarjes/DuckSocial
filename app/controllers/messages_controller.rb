class MessagesController < ApplicationController
  
  def inbox
    @messages = current_user.received_messages
  end

  def sent
    @messages = current_user.sent_messages
  end

  def new
  end
end
