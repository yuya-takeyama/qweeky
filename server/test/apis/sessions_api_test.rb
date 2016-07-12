class SessionsApiTest < BaseTestCase
  include ApiHelper

  sub_test_case 'POST /api/login' do
    setup do
      @user = create(:user, username: 'user', email: 'test@example.com', password: 'pass123')

      assert { AccessToken.count == 0 }
    end

    test 'access token is created for correct username and password' do
      json_post '/api/login', {username: 'user', password: 'pass123'}.to_json
      body = JSON.parse(last_response.body)

      assert { last_response.status == 201 }
      assert { body['user']['username'] == 'user' && body['user']['email'] == 'test@example.com' }
      assert { body['access_token']['token'].is_a? String }

      access_token = AccessToken.find_by(user_id: @user.id)

      assert { access_token.token.is_a? String }
    end

    test 'returns access token for correct email and password' do
      json_post '/api/login', {username: 'test@example.com', password: 'pass123'}.to_json
      body = JSON.parse(last_response.body)

      assert { last_response.status == 201 }
      assert { body['user']['username'] == 'user' && body['user']['email'] == 'test@example.com' }
      assert { body['access_token']['token'].is_a? String }

      access_token = AccessToken.find_by(user_id: @user.id)

      assert { access_token.token.is_a? String }
    end

    test 'error for incorrect username' do
      json_post '/api/login', {username: 'incorrect', password: 'pass123'}.to_json
      body = JSON.parse(last_response.body)

      assert { last_response.status == 401 }
      assert { body == {'error' => 'Credentials did not match'} }
    end

    test 'error for incorrect email' do
      json_post '/api/login', {username: 'incorrect@example.com', password: 'pass123'}.to_json
      body = JSON.parse(last_response.body)

      assert { last_response.status == 401 }
      assert { body == {'error' => 'Credentials did not match'} }
    end

    test 'error for incorrect password' do
      json_post '/api/login', {username: 'user', password: 'incorrect'}.to_json
      body = JSON.parse(last_response.body)

      assert { last_response.status == 401 }
      assert { body == {'error' => 'Credentials did not match'} }
    end
  end

  sub_test_case 'POST /api/logout' do
    setup do
      @user = create(:user, username: 'user', email: 'test@example.com', password: 'pass123')
      set_current_user(@user)
    end

    test 'delete access token' do
      assert { AccessToken.where(user_id: @user.id).count == 1 }

      secure_json_post '/api/logout'

      assert { last_response.status == 204 }
      assert { AccessToken.where(user_id: @user.id).count == 0 }
    end

    test 'error for unauthorized request' do
      json_post '/api/logout'

      assert { last_response.status == 401 }
    end
  end
end
