class PaymentsController < ApplicationController 
    def index()         
        @order = session[:order]
        @orders = Product.where(id: @order)  
    end  

    def create()

    end

    def update   
        if params[:remove_product_id]
            session[:order].delete(params[:remove_product_id].to_i) 
        end  
        @order = session[:order]
        @orders = Product.where(id: @order)

        render :index 
    end
end