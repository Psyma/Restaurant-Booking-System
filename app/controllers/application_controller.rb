class ApplicationController < ActionController::Base
    before_action :set_current_user 
    #before_action :redirect_if_signed_in

    def set_current_user() 
        if session[:user_id]
            Current.user = User.find(session[:user_id]) 
        end
    rescue ActiveRecord::RecordNotFound => e
        Current.user = nil
    end 
 
    private 
    def redirect_if_signed_in 
        if request.path == '/users/sign_in'
            redirect_to login_path
        end
    end 
end
