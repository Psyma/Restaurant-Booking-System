class PaymentsController < ApplicationController 
    before_action :check_user 

    def index()          
        product = session[:order]  
        if product.length != 0
            @reservation = Reservation.new()
            @order = Order.new()
            @products = Product.where(id: product)  
            @total_amount = @products.inject(0) { |sum, product| sum + product.price.to_i } 
        else
            redirect_to reservations_path
        end
    end  

    def create()
        product = session[:order]
        @products = Product.where(id: session[:order])
        
        @total_amount = @products.inject(0) { |sum, product| sum + product.price.to_i }  
        @reservation = Reservation.new(reservation_params())
        @reservation.status = Status::PENDING
        Current.user.reservations << @reservation
        
        respond_to do |format|  
            if @reservation.save
                notification = Notification.new(:title => "Pending", :content => "You have booked a table, waiting for confirmation ...", :seen => Seen::NOT_SEEN)
                notification.save
                Current.user.notifications << notification
                
                admin = User.where(role: Roles::ADMIN).first
                notification = Notification.new(:title => "Table booked", :content => "#{Current.user.first_name} has booked a table, waiting for a confirmation", :seen => Seen::NOT_SEEN)
                notification.save
                admin.notifications << notification
            
                order = Order.new(:total_amount => @total_amount)
                @products.each do |product|
                    order_product = OrderProduct.new(:product_id => product.id)
                    order.order_products << order_product
                    order_product.save
                end
                @reservation.order = order
                
                format.html { redirect_to root_path }  
            else 
                format.html { render :index } 
            end 
        end
    end 

    def update() 
        if params[:remove_product_id]
            session[:order].delete(params[:remove_product_id].to_i) 
        end  
        
        product = session[:order]
        if product.length != 0
            @reservation = Reservation.new()
            @products = Product.where(id: product)
            @total_amount = (@products.inject(0) { |sum, product| sum + product.price.to_i })

            render :index 
        else 
            redirect_to reservations_path
        end
    end

    private
    def reservation_params()
        params.require(:reservation).permit(:date)
    end  
    
    def check_user()
        if Current.user == nil
            redirect_to root_path 
        end
    end
end