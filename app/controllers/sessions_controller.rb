class SessionsController < ApplicationController
  def new
  end
  
  def create
    member = Member.authenticate(params[:first_name], params[:last_name], params[:url], params[:password])
    if member
      session[:member_id] = member.id
      flash[:notice] = "Logged in successfully."
      redirect_to root_url
    else
      flash.now[:error] = "Invalid name, URL or password."
      render :action => 'new'
    end
  end
  
  def destroy
    session[:member_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end
end
