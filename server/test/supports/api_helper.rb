module ApiHelper
  include Rack::Test::Methods
  include FactoryGirl::Syntax::Methods

  attr_reader :current_user, :current_access_token

  def app
    Rails.application
  end

  def set_current_user(user)
    @current_user = user
    @current_access_token = current_user.access_tokens.first || current_user.access_tokens.create!
  end

  [:get, :post, :put, :delete].each do |verb|
    define_method "secure_#{verb}" do |*args|
      header 'Authorization', "Token #{current_access_token.token}"
      method(verb).call(*args)
    end

    define_method "json_#{verb}" do |*args|
      header 'Content-Type', 'application/json'
      method(verb).call(*args)
    end

    define_method "secure_json_#{verb}" do |*args|
      header 'Content-Type', 'application/json'
      method("secure_#{verb}").call(*args)
    end
  end
end
