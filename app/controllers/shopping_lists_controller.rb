class ShoppingListsController < DwellingItemsController
  before_filter :get_dwelling_shopping_list
	before_filter :ensure_shopping_list_belongs_to_current_user, only: [:edit, :update, :destroy]


  # GET /shopping_lists
  # GET /shopping_lists.json
  def index
    @shopping_lists = @dwelling.shopping_lists

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shopping_lists }
    end
  end

  # GET /shopping_lists/1
  # GET /shopping_lists/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shopping_list }
    end
  end

  # GET /shopping_lists/new
  # GET /shopping_lists/new.json
  def new
    @shopping_list = @dwelling.shopping_lists.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shopping_list }
    end
  end

  # GET /shopping_lists/1/edit
  def edit
  end

  # POST /shopping_lists
  # POST /shopping_lists.json
  def create
    @shopping_list = @dwelling.shopping_lists.build(params[:shopping_list])
    @shopping_list.owner = current_user

    respond_to do |format|
      if @shopping_list.save
        format.html { redirect_to @shopping_list, notice: 'Shopping list was successfully created.' }
        format.json { render json: @shopping_list, status: :created, location: @shopping_list }
      else
        format.html { render :new }
        format.json { render json: @shopping_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shopping_lists/1
  # PUT /shopping_lists/1.json
  def update
    respond_to do |format|
      if @shopping_list.update_attributes(params[:shopping_list])
        format.html { redirect_to @shopping_list, notice: 'Shopping list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @shopping_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shopping_lists/1
  # DELETE /shopping_lists/1.json
  def destroy
    @shopping_list.destroy

    respond_to do |format|
      format.html { redirect_to shopping_lists_url }
      format.json { head :no_content }
    end
  end

	private

	def get_dwelling_shopping_list
		@dwelling = current_dwelling
		if params[:id]
			@shopping_list = @dwelling.shopping_lists.find(params[:id])
		end
	end

	def ensure_shopping_list_belongs_to_current_user
		permission_denied unless current_user == @shopping_list.owner
	end
end
