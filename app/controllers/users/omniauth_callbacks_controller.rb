# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
        handle_auth("Google")
    end

    def facebook 
        handle_auth("Facebook")
    end

    def twitter2
        handle_auth("Twitter2")
    end

    def linkedin    
        handle_auth("Linkedin")
    end

    def failure
        redirect_to root_path
    end

    def handle_auth(kind) 
        user = User.from_omniauth(request.env['omniauth.auth']) 
    
        if user.present?
            sign_out_all_scopes 
            if user.confirmed?  
                session[:user_id] = user.id()
                sign_in_and_redirect user 
            else 
                flash[:notice] = "A verification email has been sent to your email."
                redirect_to login_path
            end 
        else
            flash[:alert] = "Email already taken"
            redirect_to login_path
        end
    end  
end
