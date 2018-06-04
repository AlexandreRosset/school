class Api::ApiController < ApplicationController

  protect_from_forgery with: :null_session
  before_action :require_login!
  layout false

  def require_login!
    if authentification_success?
      return true
    else
      render json: {errors: [detail: "Access Denied"]}, status: 401
    end
  end

  private

  def authentification_success?
    if request.headers['HTTP_AUTHORIZATION']
      user = User.find_by(auth_token: request.headers['HTTP_AUTHORIZATION'])
      if user
        sign_in(user)
        return true
      else
        return false
      end
    else
      return false
    end
  end

end
