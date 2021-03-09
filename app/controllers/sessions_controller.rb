class SessionsController < ApplicationController

    def new
        # No vars needed in here. Not adding to db.
    end 


    def create
        @username = form_params[:username]
        @password = form_params[:password]

        # Checks the database (but doesn't modify it)
        # here, 'username:' matches its name in your db
        @user = User.find_by(username: @username)&.authenticate(@password)

        if @user
            session[:user_id] = @user.id
            flash[:success] = "You're now logged in."
            redirect_to root_path

        # Else, show login page again.
        else
            render "new"
            flash[:login_failed] = "Wrong username or password entered."
        end
    end 


    def destroy
        reset_session
        flash[:success] = "You are now logged out."
        redirect_to root_path
    end 


    def form_params
        # Only permit a username and a pw to be submitted through the form
        params.require(:session).permit(:username, :password)
    end 

end
