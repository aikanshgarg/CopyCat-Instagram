class UsersController < ApplicationController
  
  # search is a method defined in model
  # term is what we receive from user as input, to search
  def index
  	@users = User.search(params[:term])
  	respond_to :js  	
  end


  def show
  	@user = User.find(params[:id])
  	
  	# the below 2 variables added for updating user profile page
  	@posts = @user.posts.includes(:photos, :likes, :comments)
  	
  	@saved = Post.joins(:bookmarks).where(user_id: current_user.id).includes(:photos, :likes, :comments) if @user == current_user
  	# if condition makes sure a signed in user can see only his own saved(bookmarked) posts

  end

end
