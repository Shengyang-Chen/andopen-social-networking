class MembersController < ApplicationController
  
  def show
    @member = current_member
  end
  
  def new
    @member = Member.new
  end
  
  def create
    @member = Member.new(params[:member])
    if @member.save
      @member.site_contents.create!(url: @member.url)  # Store member website headings on member creation
      session[:member_id] = @member.id
      flash[:notice] = "Thank you for creating new member! You are now logged in as the member just created."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

end
