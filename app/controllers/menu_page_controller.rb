class MenuPageController < ApplicationController
    def index()  
        @products = Product.limit(8) 
    end 
end