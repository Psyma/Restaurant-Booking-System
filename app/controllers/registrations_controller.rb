class RegistrationsController < ApplicationController
    def index()
        @user = User.new() 
    end
 
    def create()
        @user = User.new(user_params()) 
        @user.role = Roles::CUSTOMER
        
        if @user.save()
            flash[:notice] = "A verification email has been sent to your email."
            filepath = "assets/images/default_profile.png"
            @user.image.attach('filename': "default.png", io: File.open(Rails.root.join('app', filepath))) 
            redirect_to login_path
        else 
            render :index
        end 
    end

    private
    def user_params()
        params.require(:user).permit(:first_name, :last_name, :email, :address, :password, :password_confirmation)
    end 
end