class ShoppingListItemsController < ApplicationController
  before_filter :get_shopping_list_of_item

  def index
    @shopping_list_items = ShoppingListItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shopping_list_items }
    end
  end

  # GET /shopping_list_items/1
  # GET /shopping_list_items/1.json
  def show
    @shopping_list_item = @shopping_list.shopping_list_items.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shopping_list_item }
    end
  end

  # GET /shopping_list_items/new
  # GET /shopping_list_items/new.json
  def new
    @shopping_list_item = @shopping_list.shopping_list_items.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shopping_list_item }
    end
  end

  # GET /shopping_list_items/1/edit
  def edit
    @shopping_list_item = @shopping_list.shopping_list_items.find(params[:id])
  end

  # POST /shopping_list_items
  # POST /shopping_list_items.json
  def create
    @shopping_list_item = @shopping_list.shopping_list_items.new(params[:shopping_list_item])

    respond_to do |format|
      if @shopping_list_item.save
        format.html { redirect_to shopping_list_path(@shopping_list_item.shopping_list_id), notice: 'Shopping list item was successfully created.' }
        format.json { render json: @shopping_list_item, status: :created, location: @shopping_list_item }
      else
        format.html { render :new }
        format.json { render json: @shopping_list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shopping_list_items/1
  # PUT /shopping_list_items/1.json
  def update
    @shopping_list_item = @shopping_list.shopping_list_items.find(params[:id])
    respond_to do |format|
      if @shopping_list_item.update_attributes(params[:shopping_list_item])
        format.html { redirect_to shopping_list_path(@shopping_list_item.shopping_list_id), notice: 'Shopping list item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @shopping_list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shopping_list_items/1
  # DELETE /shopping_list_items/1.json
  def destroy
    @shopping_list_item = @shopping_list.shopping_list_items.find(params[:id])
    @shopping_list_item.destroy

    respond_to do |format|
      format.html { redirect_to @shopping_list}
      format.json { head :no_content }
    end
  end

  private

  def get_shopping_list_of_item
    @shopping_list = ShoppingList.find(params[:shopping_list_id])

  end
end
