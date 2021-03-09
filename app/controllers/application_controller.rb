class ApplicationController < ActionController::Base

    # Make it a helper - make it usable in views
    helper_method :current_user, :is_logged_in?

    # Run this on every single page and action
    before_action :current_user

    def current_user
        if is_logged_in?
            # Set @current_user to the User in the database of that :user_id
            @current_user = User.find(session[:user_id])
        else
            @current_user = nil     
        end 

        return @current_user
    end 

    def is_logged_in?
        # if ... return true
        session[:user_id].present?

        # else ... return false
        end 

end
