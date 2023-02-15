class SessionsController < ApplicationController  
    before_action :redirect_if_logged_in, only: [:index]
    
    def index()   
    end 

    def login()
        user = User.find_for_authentication(email: params[:email]) 
        
        if user.present?() && user.valid_password?(params[:password])
            if user.confirmed?
                session[:user_id] = user.id()
                redirect_to root_path
            else
                flash[:alert] = "Please confirm your email"
                render :index
            end 
        else
            flash[:alert] = "Invalid email or password"
            render :index
        end 
        
        flash[:alert] = nil
    end 

    def logout()
        flash[:notice] = "Signed out successfully."
        session[:user_id] = nil
        redirect_to login_path
    end

    private
    def redirect_if_logged_in()   
        redirect_to root_path if Current.user
    end
end