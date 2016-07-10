class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:login]

  def login
    user = User.authenticate(params[:username], params[:password])

    if user
      access_token = user.access_tokens.create!

      render status: :created,
        json: {
          user: {
            username: user.username,
            email: user.email,
            bio: user.bio,
            avatar: user.avatar,
            admin: user.admin,
          },
          access_token: {token: access_token.token},
        }
    else
      render status: :aunothorized,
        json: {error: 'Credentials did not match'}
    end
  end

  def logout
    current_access_token.destroy
  end
end
