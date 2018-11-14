class LikesController < ApplicationController

	before_action :authenticate_user!
	
# this method builds/creates an entry corresponding to a post for like of current_user. Then saves the post, which has been liked, in @post instance
	def create
		@like = current_user.likes.build(like_params)
		@post = @like.post

		if @like.save
			respond_to :js
		else
			flash[:alert] = "Something went wrong ..."
		end
	end
	

	def destroy
		@like = Like.find(params[:id])
		@post = @like.post

		if @like.destroy
			respond_to :js
		else
			flash[:alert] = "Something went wrong ..."
		end
	end


	private
	def like_params
		params.permit :post_id
	end


	
end