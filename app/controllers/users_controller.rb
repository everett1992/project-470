class UsersController < ApplicationController
	layout Proc.new { |controller| current_dwelling ? 'dwelling_layout' : 'application' }
	before_filter :load_upcoming_items, if: :current_dwelling

  # GET /users/:id
  def show
    @user = User.find(params[:id])

		@bills = @user.bills
		@chores = @user.chores
		@shopping_lists = @user.shopping_lists
		@events = @user.events
		@posts = @user.posts

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /users/new
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/:id/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    if @user.save
      login @user
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
      else
        format.html { render :new}
      end
    end
  end

  # PUT /users/:id
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit}
      end
    end
  end

  # DELETE /users/:id
  def destroy
    @user = current_user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end
end
