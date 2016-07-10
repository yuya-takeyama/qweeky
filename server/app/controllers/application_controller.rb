class ApplicationController < ActionController::API
  before_action :authenticate

  def authenticate
    render status: :unauthorized,
      json: {error: 'Unauthorized'} unless current_user
  end

  def current_user
    @current_user ||= current_access_token&.user
  end

  def current_access_token
    @current_access_token ||= AccessToken.find_by(token: authorization_token)
  end

  private
    def authorization_token
      request.headers['Authorization']&.match(/\Atoken\s+([^\s]*)\z/i)&.[](1)
    end
end
