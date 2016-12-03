Rails.application.routes.draw do
  
  resources :phase1s do
    collection do
      post :import
      get "remove_all"
    end
  end
  
  resources :phase1_results
  
  resources :phase2s do
    collection do
      post :import
      get "remove_all"
    end
  end
  
  resources :phase2_results
  
  root to: "pages#home"
  
  devise_for :users
  get '/users/index' => 'user#index'
  
  controller :pages do
    get :home
  end
end
