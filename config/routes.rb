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
    
    # Singular - one session at a time
    resource :session
    
    
    get "about", to: "pages#about"
    
    root "pages#home"
end
