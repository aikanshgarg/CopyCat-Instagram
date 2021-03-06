class User < ApplicationRecord
	has_many :posts, dependent: :destroy
	has_many :likes
	has_many :comments
	has_many :bookmarks




  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:twitter]


  validates :name, presence: true, length: {maximum: 50}

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.name = auth.info.name   # assuming the user model has a name
	    user.image = auth.info.image.gsub!("_normal","") # assuming the user model has an image, we are removing normal parameter from twitter's url of user image so that image is more clear

	    # we added these two 
	    user.uid = auth.uid
	    user.provider = auth.provider
	    

	    # If you are using confirmable and the provider(s) you use validate emails, 
	    # uncomment the line below to skip the confirmation emails.
	    # user.skip_confirmation!
	  end
	end

 	# function receives a query (example: "Aik") in variable term and searches in User table for column => name
	def self.search(term)
		if term
			where('name LIKE ?', "%#{term}%")
			# % sign at both start and end of "%#{term}%" signifies that the searched query can be middle part of complete name as well.
			# Example: "tro" can search "Stro" as well as "trong" as well as "Strong"   
		else
			nil
		end		
	end


end
