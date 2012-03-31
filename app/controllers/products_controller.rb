class ProductsController < ApplicationController
  DEFAULT_VIEW="thumbnail"
  DEFAULT_PER_PAGE=8
  
  def index
    # Enable rendering of controls partial for products
    @control = true
    
    # Handling View Layout 
    select_view
    
    # Handling Items per page
    select_page_size

    @products = Product.where(apply_name_filter).where(apply_price_filter).page(params[:page]).per(session[:page_size])
    
  end 
  
  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
  
  # Start of private methods
  private
  
  def select_view
    session[:view_layout] = params[:view_layout] unless params[:view_layout].blank?
    session[:view_layout] = DEFAULT_VIEW if session[:view_layout].blank?
  end
  
  def select_page_size()
    session[:page_size] = params[:page_size] unless params[:page_size].blank? 
    session[:page_size] = DEFAULT_PER_PAGE if session[:page_size].blank?
  end
  
  def apply_name_filter
    
    #Initialization of session filter if not defined yet
    session[:filter] ||= []
    
    # Get filters from params and add it to session
    unless params[:product].blank?
      # Handling addition of new tags 
      session[:filter] << params[:product]
      session[:filter].uniq!
    end
    
    # If operation include clear filters remove all filters
    session[:filter] = [] if params[:clear_all]=="true"
    
    # Remove specific filter
    unless params[:remove_filter].blank?
      session[:filter].delete_if { |filter| filter==params[:remove_filter] }
    end
    
    # Build query
    query=[session[:filter].map {|x| "name like ?"}.join(" or ")]
    session[:filter].each {|x| query<<"%#{x}%" }
    
    # Return the query string to be passed to the model
    query
    
  end
  
  def apply_price_filter
    
    #Initialization of session filter if not defined yet
    session[:price_base] ||= Range.new(Product.minimum(:price).to_f, Product.maximum(:price).to_f)
    session[:price] = session[:price_base]
    unless params[:price].blank?
      price_range = params[:price].split("..")
      logger.debug price_range
      session[:price] = Range.new(price_range[0].to_s,price_range[1])
    end
    
    query = {:price => session[:price]}
    query
  end
  
  
end
