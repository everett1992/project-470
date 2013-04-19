# Administration controller for dwelling owner
class DwellingsController < ApplicationController
  #before_filter :logged_in?
  #before_filter :except => [:new, :create] do |c|
  #  c.dwelling_member?(params[:id].to_i)
  #end
  #before_filter :only => [:edit, :update, :destroy] do |c|
  #  c.dwelling_owner?(params[:id].to_i)
  #end

  # GET /dwellings/1
  def show
    @dwelling = Dwelling.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
    end
  end

  # GET /dwellings/new
  def new
    @dwelling = Dwelling.new

    respond_to do |format|
      format.html # new.html.haml
    end
  end

  # GET /dwellings/1/edit
  def edit
    @dwelling = Dwelling.find(params[:id])
  end

  # Create a new dwelling, set the creating user
  # as the dwelling owner, and a roomate of the dwelling.
  # POST /dwellings
  def create
    params[:dwelling][:owner] = current_user
    @dwelling = Dwelling.new(params[:dwelling])
    if @dwelling.save
      current_user.dwelling = @dwelling
      current_user.save
    end
    respond_to do |format|
      if @dwelling.valid?
        format.html { redirect_to root_path,
          notice: 'Dwelling was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /dwellings/1
  def update
    @dwelling = Dwelling.find(params[:id])

    respond_to do |format|
      if @dwelling.update_attributes(params[:dwelling])
        format.html { redirect_to @dwelling,
          notice: 'Dwelling was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /dwellings/1
  def destroy
    @dwelling = Dwelling.find(params[:id])
    @dwelling.destroy

    respond_to do |format|
      format.html { redirect_to dwellings_url }
    end
  end

end
