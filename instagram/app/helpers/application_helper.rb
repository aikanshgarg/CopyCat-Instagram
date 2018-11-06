module ApplicationHelper
	# what if our user has no image! This would help the image_tag helper to deal with it!
	def avatar_url user
		return user.image if user.image
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase
		"https://en.gravatar.com/avatar/#{gravatar_id}.jpg"
	end

end
