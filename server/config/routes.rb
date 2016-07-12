Rails.application.routes.draw do
  scope path: '/api' do
    get 'pages/*path' => 'pages#show'
    put 'pages/*path' => 'pages#update'

    post 'login'  => 'sessions#login'
    post 'logout' => 'sessions#logout'

    resources :users
  end
end
