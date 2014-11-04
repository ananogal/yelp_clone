Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  
  root to:"restaurants#index"

  resources :restaurants do
    resource :reviews
  end
end
