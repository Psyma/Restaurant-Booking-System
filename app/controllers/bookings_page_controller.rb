class BookingsPageController < ApplicationController
    before_action :check_user 
    
    def index()   
        @reservations = Reservation.paginate(:page => params[:page], per_page: 10)   
        session[:page] = params[:page]
    end 

    def confirm() 
        reservation = Reservation.find(params[:reservation_id]) 
        if reservation.status != Status::CONFIRMED  
            reservation.update(:status => Status::CONFIRMED)
            
            notification = Notification.new(:title => "Confirmed", :content => "You have a table reservation on #{reservation.date}", :seen => Seen::NOT_SEEN)
            notification.save
            user = User.find(reservation.user_id)
            user.notifications << notification
            
            admin = User.where(role: Roles::ADMIN).first
            notification = Notification.new(:title => "Table booked confirmed", :content => "A table booked by #{user.first_name} has been confirmed", :seen => Seen::NOT_SEEN)
            notification.save
            admin.notifications << notification  
        end

        @reservations = Reservation.paginate(:page => session[:page], per_page: 10)  
        render :index
    end

    def decline()
        reservation = Reservation.find(params[:reservation_id]) 
        if reservation.status != Status::DECLINED  
            reservation.update(:status => Status::DECLINED)

            notification = Notification.new(:title => "Declined", :content => "Sorry! your table reservation has been decline", :seen => Seen::NOT_SEEN)
            notification.save
            user = User.find(reservation.user_id)
            user.notifications << Notification

            admin = User.where(role: Roles::ADMIN).first
            notification = Notification.new(:title => "Table booked declined", :content => "A table booked by #{user.first_name} has been declined", :seen => Seen::NOT_SEEN)
            notification.save
            admin.notifications << notification 
        end

        @reservations = Reservation.paginate(:page => session[:page], per_page: 10)  
        render :index
    end 

    private
    def check_user
        if Current.user == nil
            redirect_to root_path 
        end
    end
end