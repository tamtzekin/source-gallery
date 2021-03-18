class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def show
    end 

    def create
        @user = User.new(form_params)
        
        # Check if the user can save
        if @user.save_and_subscribe
            # Hold that user's session
            # setting :user_id as a new var here
            session[:user_id] = @user.id

            # Let the user know they've signed up
            flash[:new_user_success] = "Congrats. You've signed up to Source."

            redirect_to root_path
            # TODO: show success message
        else
            render "new"
            # TODO: show error message

        end 
    end


    def form_params
        params.require(:user).permit(
            :name, :username, :email, :password, :password_confirmation, :subscription_plan
        )
    end 


end
