class ChoresController < ApplicationController
  before_filter :get_dwelling_and_chore
	before_filter :ensure_chore_belongs_to_current_user, only: [:edit, :update, :destroy]

  # GET /chores
  # GET /chores.json
  def index
    @chores = @dwelling.chores

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chores }
    end
  end

  # GET /chores/1
  # GET /chores/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chore }
    end
  end

  # GET /chores/new
  # GET /chores/new.json
  def new
    @chore = Chore.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chore }
    end
  end

  # GET /chores/1/edit
  def edit
  end

  # POST /chores
  # POST /chores.json
  def create
    @chore = @dwelling.chores.build(params[:chore])
    @chore.owner = current_user

    respond_to do |format|
      if @chore.save
        format.html { redirect_to @chore, notice: 'Chore was successfully created.' }
        format.json { render json: @chore, status: :created, location: @chore }
      else
        format.html { render action: "new" }
        format.json { render json: @chore.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chores/1
  # PUT /chores/1.json
  def update
    respond_to do |format|
      if @chore.update_attributes(params[:chore])
        format.html { redirect_to @chore, notice: 'Chore was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chore.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chores/1
  # DELETE /chores/1.json
  def destroy
    @chore.destroy

    respond_to do |format|
      format.html { redirect_to chores_url }
      format.json { head :no_content }
    end
  end

	private

  def get_dwelling_and_chore
    @dwelling = current_dwelling
    if params[:id]
      @chore = @dwelling.chores.find(params[:id])
    end
  end

	def ensure_chore_belongs_to_current_user
		permission_denied unless current_user == @chore.owner
	end
end
