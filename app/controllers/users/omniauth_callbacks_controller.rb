class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController  
    def google_oauth2
        handle_auth("Google")
    end

    def facebook 
        handle_auth("Facebook")
    end

    def twitter2
        handle_auth("Twitter")
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
            flash[:success] = t 'devise.omniauth_callbacks.success', kind: kind  
            session[:user_id] = user.id 
            sign_in_and_redirect user 
          else
            flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: kind, reason: "#{user.email} is not authorized."
            redirect_to registrations_path
        end
    end 
end