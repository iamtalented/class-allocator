Rails.application.routes.draw do
  
  resources :phase1s do
    collection { post :import }
  end
  
  resources :phase1_results
 
  root to: "phase1s#new"
  
  devise_for :users
  get '/users/index' => 'user#index'
end
