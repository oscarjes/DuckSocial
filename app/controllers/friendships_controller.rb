class FriendshipsController < ApplicationController

  def create
    current_user.friendships.create!(friendship_params)
    redirect_to users_path
  end

  def destroy
    other_user = User.find params[:friend_id]
    current_user.friends.delete(other_user)
    redirect_to users_path
  end

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
