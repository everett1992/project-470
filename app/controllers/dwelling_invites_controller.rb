# Dwelling Owner controller for inviting roomates to
# a delling.
class DwellingInvitesController < DwellingItemsController
  before_filter do |c|
    # Only dwelling owner has access.
    c.dwelling_owner?(params[:dwelling_id].to_i)
  end

  # List all invites belonging to this dwelling.
  # GET /invites/
  def index
    @dwelling = Dwelling.find(params[:dwelling_id])
    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # Creates a form to create a invite to this dwelling.
  # GET /invites/new
  def new
    @invite = Invite.new(dwelling_id: params[:dwelling_id])

    respond_to do |format|
      format.html # new.html.haml
    end
  end

  # Create a new invite to this dwelling.
  # POST /invites
  def create
    @invite = current_dwelling.invites.new(params[:invite])
    if @invite.save
      # Mail a link to join the dwelling to the invitee.
      InviteMailer.invite(@invite, invites_url(@invite.token)).deliver
    end

    respond_to do |format|
      if @invite.save
        format.html { redirect_to dwelling_path(@invite.dwelling_id),
          notice: 'Invite was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # Delete an invite, preventing the invited user from joining the dwelling.
  # DELETE /invites/1
  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy

    respond_to do |format|
      format.html { redirect_to dwelling_path @invite.dwelling_id}
    end
  end
end
