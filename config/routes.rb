Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  
  root to:"restaurants#index"

  resources :restaurants, shallow:true do
    resource :reviews do
    	resource :endorsements
    end
  end
end
