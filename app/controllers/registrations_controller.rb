class RegistrationsController < ApplicationController
    def index()
        @user = User.new() 
    end
 
    def create()
        @user = User.new(user_params()) 
        @user.role = 0
        
        if @user.save()
            session[:user_id] = @user.id()
            redirect_to root_path
        else 
            render :index
        end 
    end

    private
    def user_params()
        params.require(:user).permit(:first_name, :last_name, :email, :address, :password, :password_confirmation)
    end 
end