Rails.application.routes.draw do
  scope path: '/api' do
    post 'login'  => 'sessions#login'
    post 'logout' => 'sessions#logout'

    resources :users
  end
end
