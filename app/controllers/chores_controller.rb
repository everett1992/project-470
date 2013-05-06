class ChoresController < DwellingItemsController
  before_filter :get_dwelling_and_chore
	before_filter :ensure_chore_belongs_to_current_user, only: [:edit, :update, :destroy]

  # GET /chores
  # GET /chores.json
  def index
    if params[:inactive]
      @chores = @dwelling.chores.inactive
    else
      @chores = @dwelling.chores.active
    end

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
    @chore.active = true

    # Make the actual cron-format string
    cron_cmd = "/bin/bash -l -c 'cd #{Rails.root} && bundle exec rake chores:activate_chore CHORE_ID="
    case @chore.cron_str
    when "Every M/W/F"
      @chore.cron_str = "0 0 * * MON,WED,FRI #{cron_cmd}"
    when "Every T/Th"
      @chore.cron_str = "0 0 * * TUE,THU #{cron_cmd}"
    when "Every Sunday"
      @chore.cron_str = "0 0 * * SUN #{cron_cmd}"
    else
      @chore.cron_str = nil
    end

    # if @chore.cron_str
    #   puts @chore.cron_str
    #   puts (CronEdit::Crontab.Add "chore_#{params[:id]}", @chore.cron_str)
    # end

    respond_to do |format|
      if @chore.save
        if @chore.cron_str
          puts @chore.cron_str
          puts (CronEdit::Crontab.Add "chore_#{@chore.id}", "#{@chore.cron_str}#{@chore.id}'")
        end
        format.html { redirect_to @chore, notice: 'Chore was successfully created.' }
        format.json { render json: @chore, status: :created, location: @chore }
      else
        format.html { render :new }
        format.json { render json: @chore.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chores/1
  # PUT /chores/1.json
  def update
    # TODO: Add cron_str updating
    respond_to do |format|
      if @chore.update_attributes(params[:chore])
        format.html { redirect_to @chore, notice: 'Chore was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @chore.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chores/1
  # DELETE /chores/1.json
  def destroy
    if @chore.cron_str
      puts "Removing #{@chore.id} from crontab #{@chore.cron_str}"
      CronEdit::Crontab.Remove "chore_#{@chore.id}"
    end

    @chore.destroy

    respond_to do |format|
      format.html { redirect_to chores_url }
      format.json { head :no_content }
    end
  end

  # PUT /chores/1/deactivate
  # PUT /chores/1/deactivate.json
  def deactivate
    permission_denied unless @chore.active
    @chore.update_attribute(:active, false)
    redirect_to chores_url, notice: "Chore was successfully deactivated"
  end

  private

  # Assign @dwelling and @chore if applicable
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
