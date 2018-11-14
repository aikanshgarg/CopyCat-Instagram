class BookmarksController < ApplicationController
  
  before_action :authenticate_user!


# this method builds/creates an entry corresponding to a post for bookmark of current_user. Then saves the post, which has been bookmarked, in @post instance
	def create
		@bookmark = current_user.bookmarks.build(bookmark_params)

		if @bookmark.save
			@post = @bookmark.post
			 @is_bookmarked = @bookmark
			respond_to :js
		else
			flash[:alert] = "Something went wrong ..."
		end
	end

	def destroy
		@bookmark = Bookmark.find_by(params[:id])
		@post = @bookmark.post
		if @bookmark.destroy
			respond_to :js
		else
			flash[:alert] = "Something went wrong ..."
		end
	end

	private
	def bookmark_params

		# params.require(:bookmark).permit :user_id, :post_id
		
		# we don't need a require here as we needed in like feature. Reason: we are simply sending a request through link/anchor tag for bookmark, while, for like we wanted to save it in our database on clicking like link
		

		params.permit :user_id, :post_id
	end

end
