Rails.application.routes.draw do

  # ActiveAdmin URLs
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
    # Categories controller
    resources :categories

    # Items controller
    resources :items
    
    # Users can sign up multiple time/make many users
    resources :users
        
    # User can only have 1 session at a time
    resource :session

    # User can only have 1 account at a time
    resource :account
    

    get "about", to: "pages#about"
    
    root "pages#home"
end
