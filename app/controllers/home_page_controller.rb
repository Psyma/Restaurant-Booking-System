class HomePageController < ApplicationController 
    def index()        
        flash[:alert] = nil
        flash[:notice] = nil
        session[:order] = []
        @comment = Comment.new()
        @products = Product.limit(8)  
        @users = User.where(:role => Roles::CUSTOMER)
    end  
    
    def create() 
        session[:order] = []
        @products = Product.limit(8)  
        @users = User.where(:role => Roles::CUSTOMER)
        
        @comment = Comment.new(comment_params())
        if @comment.save
            Current.user.comments << @comment
            redirect_to root_path
        else
            render :index
        end
    end
    
    def update()     
        Current.user.notifications.update_all(seen: Seen::HAS_SEEN) 
        @products = Product.limit(8)  
    end

    private
    def comment_params()
        params.require(:comment).permit(:contents)
    end
end