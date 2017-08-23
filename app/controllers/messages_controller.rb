class MessagesController < ApplicationController
  before_action :require_login, only: [:inbox, :sent, :new] 
  
  def inbox
    @messages = current_user.received_messages.sort_by(&:created_at).reverse
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
      #MessageMailer.new_message(message).deliver_now
      flash[:success] = "Message sent."
      redirect_to sent_path
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect_to messages_new_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :body)
  end
end
