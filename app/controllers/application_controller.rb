class ApplicationController < ActionController::Base
  protect_from_forgery


  # convert times from utc to the odwelling's timezone
  before_filter :get_dwelling_time_zone

  private


	# Adjusts UTC time saved in database to match dwellings timezone
  def get_dwelling_time_zone
    Time.zone = current_dwelling.time_zone if current_dwelling
  end

  # Creates a session for a users
  def login user
    session[:user_id] = user.id
  end

  # Destroys the users session
  def logout
    session[:user_id] = nil
  end

  # Returns the user set in the session
	def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  # Returns the dwelling of the user set in the session
  def current_dwelling
    @current_dwelling ||= current_user.dwelling if current_user
  end


  # Redirect to Permission denied page
  def permission_denied
		respond_to do |format|
			format.html { render 'application/permission_denied' }
			format.json { render json: 'Permission Denied' }
		end
  end


  protected

	# If user is not logged in redirect them to the login path
  def logged_in?
    unless current_user
      redirect_to login_path, notice: 'You must be logged in to do that.'
    end
  end

  # Redirect a user to permission denied if they are not a member of the dwelling they
  # are accessing
  def dwelling_member?(dwelling_id)
    unless current_user.dwelling_id == dwelling_id.to_i
      permission_denied
    end
  end

  # Redirect a user to permission denied if they are not the owner of the dwelling they
  # are accessing
  def dwelling_owner?(dwelling_id)
    unless ( current_user.owned_dwelling &&
            current_user.owned_dwelling.id == dwelling_id.to_i )
      permission_denied
    end
  end

	# Load important, upcoming items
	def load_upcoming_items
		@roommates = current_dwelling.users
		@shopping_lists = current_dwelling.shopping_lists

		@upcoming_bills = current_dwelling.bills.upcoming
		@upcoming_events = current_dwelling.events.upcoming
		@upcoming_chores = current_dwelling.chores
	end

  # Helper methods are accessable to views
  helper_method :current_user
  helper_method :current_dwelling
end
