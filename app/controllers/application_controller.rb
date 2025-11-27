class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :change_user_avatar, if: :devise_controller?

  private

  def change_user_avatar
    devise_parameter_sanitizer.permit(:account_update, keys: [:photo])
  end
end
