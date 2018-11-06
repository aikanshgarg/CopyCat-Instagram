class PostsController < ApplicationController
  

  before_action :authenticate_user!
  before_action :find_post, only: [:show]


  # includes is like a join table between posts and photos
  def index
  	@posts = Post.all.limit(10).includes(:photos, :user).order('created_at desc')
  	@post = Post.new
  end


# build creates a new record with current user's id 
  def create
  	@post = current_user.posts.build(post_params)
  	if @post.save
  		if params[:images]
  			params[:images].each do |img|
  				@post.photos.create(image: params[:images][img])
  			end
  		end
  		redirect_to posts_path
  		flash[:notice] = "New post added..."
  	else
  		flash[:alert] = "Something went wrong..."
  		redirect_to posts_path
  	end
  end


  def show
    @photos = @post.photos
  end

  private
  def find_post
  	@post = Post.find_by id: params[:id]

  	return if @post
  	flash[:danger] = "Post not found!"
  	redirect_to root_path	
  end

# post_params method uses STRONG PARAMS which has 'require' and 'permit' to make sure we can't create or edit posts by changing data from opening chrome developer tools only! Only the content is visible from that side, not the post_id
  def post_params
  	params.require(:post).permit :content
  end

end
