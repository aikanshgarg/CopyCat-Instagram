class ApplicationController < ActionController::Base


# this allows us to add fields to devise, in this case -> name, for same user. It helps us to show name field on devise form

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected
	
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
		devise_parameter_sanitizer.permit(:account_update, keys: [:name, :website, :bio])		
	end

end
