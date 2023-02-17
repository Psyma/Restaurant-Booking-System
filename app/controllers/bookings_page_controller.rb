class BookingsPageController < ApplicationController
    before_action :check_user 
    
    def index()    
        @q = User.ransack(params[:q])
        if @q.result
            @reservations = Reservation.where(:user_id => @q.result.map(&:id)).paginate(:page => params[:page], per_page: 8)  
        else
            @reservations = Reservation.paginate(:page => params[:page], per_page: 8)  
        end 
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
            notification = Notification.new(:title => "Confirmed", :content => "A table booked by #{user.first_name} has been confirmed", :seen => Seen::NOT_SEEN)
            notification.save
            admin.notifications << notification  
        end

        ransack_search()
        render :index
    end

    def decline()
        reservation = Reservation.find(params[:reservation_id]) 
        if reservation.status != Status::DECLINED  
            reservation.update(:status => Status::DECLINED)

            notification = Notification.new(:title => "Declined", :content => "Sorry! your table reservation has been decline", :seen => Seen::NOT_SEEN)
            notification.save
            user = User.find(reservation.user_id)
            user.notifications << notification

            admin = User.where(role: Roles::ADMIN).first
            notification = Notification.new(:title => "Declined", :content => "A table booked by #{user.first_name} has been declined", :seen => Seen::NOT_SEEN)
            notification.save
            admin.notifications << notification 
        end

        ransack_search()
        render :index
    end 

    def cancel()
        reservation = Reservation.find(params[:reservation_id])
        reservation.update(:status => Status::CANCELED) 

        notification = Notification.new(:title => "Canceled", :content => "You canceled your reservation.", :seen => Seen::NOT_SEEN)
        notification.save
        Current.user.notifications << notification
        
        admin = User.where(role: Roles::ADMIN).first
        notification = Notification.new(:title => "Canceled", :content => "#{Current.user.first_name} has canceled its reservation.", :seen => Seen::NOT_SEEN)
        notification.save
        admin.notifications << notification
        
        redirect_to bookings_path
    end

    def destroy()
        reservation = Reservation.find(params[:reservation_id])
        reservation.update(:status => Status::DELETED) 

        notification = Notification.new(:title => "Deleted", :content => "Reservation is deleted", :seen => Seen::NOT_SEEN)
        notification.save
        Current.user.notifications << notification
        
        admin = User.where(role: Roles::ADMIN).first
        notification = Notification.new(:title => "Deleted", :content => "#{Current.user.first_name} has deleted its reservation.", :seen => Seen::NOT_SEEN)
        notification.save
        admin.notifications << notification

        redirect_to bookings_path
    end

    private
    def ransack_search()
        @q = User.ransack(params[:q])
        if @q.result
            @reservations = Reservation.where(:user_id => @q.result.map(&:id)).paginate(:page => session[:page], per_page: 8)  
        else
            @reservations = Reservation.paginate(:page => session[:page], per_page: 8)  
        end 
    end

    def check_user()
        if Current.user == nil
            redirect_to root_path 
        end
    end
end