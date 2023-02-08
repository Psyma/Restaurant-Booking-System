class HomePageController < ApplicationController 
    def index()        
        session[:order] = []
        @products = Product.limit(8)
    end  
end