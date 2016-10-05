Rails.application.routes.draw do
  devise_for :users
  get '/users/index' => 'user#index'

  resources :phase1s do
    collection { post :import }
  end
  get '/phase1s/next' => 'phase1#next'
  
end
