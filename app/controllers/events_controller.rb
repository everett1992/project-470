  class EventsController < DwellingItemsController
  before_filter :get_dwelling_and_event
	before_filter :ensure_event_belongs_to_current_user, only: [:edit, :update, :destroy]


  # GET /events
  # GET /events.json
  def index
		if params[:past]
			@events = @dwelling.events.order('date DESC').where(['date < ?', Date.today()])
		else
			@events = @dwelling.events.order(:date).where(['date >= ?', Date.today()])
		end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = @dwelling.events.build
    @event.date = Time.now

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = @dwelling.events.build(params[:event])
    @event.owner = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_path(@event), notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render :new}
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to event_path(@event), notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_path }
      format.json { head :no_content }
    end
  end

  private

  def get_dwelling_and_event
    @dwelling = current_dwelling
    if params[:id]
      @event = @dwelling.events.find(params[:id])
    end
  end

	def ensure_event_belongs_to_current_user
		permission_denied unless current_user == @event.owner
	end
end
