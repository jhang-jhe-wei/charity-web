class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :line

  def line
    user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in user
    redirect_to root_path
  end

  def failure
    redirect_to new_user_session_path
  end
end
