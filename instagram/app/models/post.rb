class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy



# this method take a variable/argument 'user' which comes/is passed from the view and returns true or false depending upon if the signed-in user is the owner of the post
  def is_belongs_to? user
  	Post.find_by(user_id: user.id, id: id)
  	# Post.find_by(user_id: user.id, id: self.id) both are same, it's just that self is not required, rails is smart!
  end
end
