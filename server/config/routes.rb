Rails.application.routes.draw do
  post 'login'  => 'sessions#login'
  post 'logout' => 'sessions#logout'

  resources :users
end
