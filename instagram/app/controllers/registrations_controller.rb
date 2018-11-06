# we are doing this to Allow users to edit their account without providing a password, code taken from devise wiki page

class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end

