Rails.application.routes.draw do
    # Users can sign up multiple time/make many users
    resources :users

    # Singular - one session at a time
    resource :session

    get "about", to: "pages#about"
    
    root "pages#home"
end
