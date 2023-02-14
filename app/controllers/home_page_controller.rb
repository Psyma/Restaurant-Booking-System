class HomePageController < ApplicationController 
    def index()        
        session[:order] = []
        @products = Product.limit(8)  
    end  
    
    def update     
        Current.user.notifications.update_all(seen: Seen::HAS_SEEN) 
        @products = Product.limit(8) 
    end
end