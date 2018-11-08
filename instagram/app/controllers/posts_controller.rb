class PostsController < ApplicationController
  

  before_action :authenticate_user!
  before_action :find_post, only: [:show, :destroy]


  # includes is like a join table between posts and photos
  def index
  	@posts = Post.all.limit(10).includes(:photos, :user, :likes).order('created_at desc')
  	@post = Post.new
  end


# build creates a new record with current user's id 
  def create
  	@post = current_user.posts.build(post_params)
  	if @post.save
  		if params[:images]
  			params[:images].each do |img|
  				@post.photos.create(image: img[1])
          # img  is a hash, and img[1]   will return image object.
  			end
  		end
  		redirect_to posts_path
  		flash[:notice] = "New post added ..."
  	else
  		flash[:alert] = "Something went wrong ..."
  		redirect_to posts_path
  	end
  end

# show method is for showing a particular post
  def show
    @photos = @post.photos
    @likes = @post.likes.includes(:user)
    @is_liked = @post.is_liked(current_user)
  end

# for deleting a post
  def destroy
  # check signed in user is the creator of post
    if @post.user == current_user 
      if @post.destroy
        flash[:notice] = "Post deleted!"
      else
        flash[:alert] = "Something went wrong ..."
      end
    else
      flash[:notice] = "You don't have permission to do that!"
    end
    redirect_to root_path
  end

  private
  def find_post
  	@post = Post.find_by id: params[:id]

# returns to the method which called find_post, if a post is found. Else, flashes danger. Finally redirects to root
  	return if @post
  	flash[:danger] = "Post not found!"
  	redirect_to root_path	
  end

# post_params method uses STRONG PARAMS which has 'require' and 'permit' to make sure we can't create or edit posts by changing data from opening chrome developer tools only! Only the content is visible from that side, not the post_id
  def post_params
  	params.require(:post).permit :content
  end

end
