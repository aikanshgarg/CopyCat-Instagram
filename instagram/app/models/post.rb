class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> {order(:created_at => :desc)}
  has_many :comments, -> {order(:created_at => :desc)}
  has_many :bookmarks




# this method take a variable/argument 'user' which comes/is passed from the view and returns true or false depending upon if the current signed-in user is the owner of the post
  def is_belongs_to? user
  	Post.find_by(user_id: user.id, id: id)
  	# Post.find_by(user_id: user.id, id: self.id) both are same, it's just that self is not required, rails is smart!
  end

# method to check if current post has been liked by current signed-in user or not, returns like_id 
  def is_liked user
  	Like.find_by(user_id: user_id, post_id: id)
  end

# bookmark is same as like feature
  def is_bookmarked user
    Bookmark.find_by(user_id: user_id, post_id: id)
  end
  
end
