class FriendshipsController < ApplicationController

  def create
    current_user.friendships.create!(friendship_params)
    flash[:success] = "Great, you've made a new friend! Add even more friends below!"
    redirect_to friends_new_path
  end

  def destroy
    other_user = User.find params[:friend_id]
    current_user.friends.delete(other_user)
    flash[:notice] = "Friend removed :("
    redirect_to users_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
