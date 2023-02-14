class ReservationsController < ApplicationController 
    before_action :redirect_if_logged_in, only: [:index] 

    def index()   
        @q = Product.ransack(params[:q])
        if @q.result() 
            @products = @q.result() 
            @products = @products.paginate(:page => params[:page], per_page: 10)  
        else
            @products = Product.paginate(:page => params[:page], per_page: 10)  
        end

        session[:page] = params[:page]  
        @order = session[:order] 
    end 

    def update    
        if !session[:order].include?(params[:product_id].to_i) 
            session[:order].push(params[:product_id].to_i)  
        else
            session[:order].delete(params[:product_id].to_i)  
        end 
        
        @q = Product.ransack(params[:q])
        @products = Product.paginate(:page => session[:page] , per_page: 10)  
        @order = session[:order] 

        render :index
    end 

    private
    def reservation_params()
        params.require(:reservation).permit(:user_id, :date)
    end 
     
    def redirect_if_logged_in     
        redirect_to login_path if Current.user == nil
    end
end