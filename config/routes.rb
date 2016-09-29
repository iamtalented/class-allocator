Rails.application.routes.draw do
  devise_for :users
#devise_for :users
 get '/users/index' => 'user#index'
 get '/users/sign_up' => 'user#sign_up'

end
