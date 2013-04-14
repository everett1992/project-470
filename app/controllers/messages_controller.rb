class MessagesController < ApplicationController
	before_filter :get_dwelling_and_message
	before_filter :ensure_message_belongs_to_current_user, only: [:edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = @dwelling.messages.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])
    @message.dwelling = current_dwelling
    @message.owner = current_user


    respond_to do |format|
      if @message.save
        format.html { redirect_to root_path, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  private

  def get_dwelling_and_message
    @dwelling = current_dwelling
    if params[:id]
      @message = @dwelling.messages.find(params[:id])
    end
  end

	def ensure_message_belongs_to_current_user
		permission_denied unless current_user == @message.owner
	end
end