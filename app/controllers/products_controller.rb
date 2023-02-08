class ProductsController < ApplicationController
    before_action :set_product, only: %i[ show edit update destroy ]
    before_action :check_user

    # GET /products or /products.json
    def index 
        @q = Product.ransack(params[:q])
        if @q.result() 
            @products = @q.result() 
            @products = @products.paginate(:page => params[:page], per_page: 8)  
        else
            @products = Product.paginate(:page => params[:page], per_page: 8)  
        end
    end

    # GET /products/1 or /products/1.json
    def show
    end

    # GET /products/new
    def new
        @product = Product.new
    end

    # GET /products/1/edit
    def edit
    end

    # POST /products or /products.json
    def create
        @product = Product.new(product_params)

        respond_to do |format|
            if @product.save
                if !params[:product][:image].present?()
                    filepath = "assets/images/default_menu.png"
                    @product.image.attach('filename': "default.png", io: File.open(Rails.root.join('app', filepath))) 
                end
                format.html { redirect_to new_product_path, notice: "Product was successfully created." }
                format.json { render :new, status: :created, location: @product }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @product.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /products/1 or /products/1.json
    def update
        respond_to do |format|
        if @product.update(product_params)
            format.html { redirect_to products_path, notice: "Product was successfully updated." }
            format.json { render :show, status: :ok, location: @product }
        else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @product.errors, status: :unprocessable_entity }
        end
        end
    end

    # DELETE /products/1 or /products/1.json
    def destroy
        @product.destroy

        respond_to do |format|
            format.html { redirect_to products_path, notice: "Product was successfully deleted." }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product 
        @product = Product.find(params[:id])  
    end

    # Only allow a list of trusted parameters through.
    def product_params   
        params.require(:product).permit(:name, :cooking_time, :price, :is_available, :image)
    end

    def check_user
        if Current.user == nil
            redirect_to root_path
        else
            if Current.user.role == Roles::CUSTOMER
                redirect_to root_path
            end
        end
    end
end
