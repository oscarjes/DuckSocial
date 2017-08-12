class MessagesController < ApplicationController
  
  def inbox
    @messages = current_user.received_messages
  end

  def sent
    @messages = current_user.sent_messages.reverse
  end

  def new
    @message = Message.new
    @users = User.where.not(id: current_user.id)
  end

  def create
    message = current_user.sent_messages.create(message_params)
    if message.save
      flash[:success] = "Message sent."
      redirect_to sent_path
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect_to messages_new_path
    end
  end

  def message_params
    params.require(:message).permit(:recipient_id, :body)
  end
end
