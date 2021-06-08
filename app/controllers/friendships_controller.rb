class FriendshipsController < ApplicationController
  def create
    @friendship = current_member.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added as friend."
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end
  
  def destroy
    @friendship = current_member.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed from friend list."
    redirect_to current_member
  end
end
