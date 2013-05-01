# This controller might not stay around. For now it serves as a homepage
# for users or dwellings
#
# The main reason this design is used it to allow roomie.com to point to a splash page,
# or the dwelling dashboard if the user is logged in or not.
class DashboardController < ApplicationController
	# FIXME: Can I set the layout and before filter in one if statement?
	layout Proc.new { |controller| current_dwelling ? 'dwelling_layout' : 'application' }
	before_filter :load_upcoming_items, if: :current_dwelling

  # This is the root path in the application
  # Logged in users will see their dashboard,
  # people who arn't logged in will see a blurb on
  # Roomie, and be prompted to signup or login.
  def index
		if current_dwelling
			# Show the users dashboard
			@messages = current_dwelling.messages.newest
			render :dashboard
		elsif current_user
        # The user is logged in, but not a member of a 
        # dwelling, prompt them to join a dwelling
        render :join_dwelling
		else
      # The user is not logged in, tell them about the 
      # application, and ask them to signup, or login
      @user = User.new
      render :signup
		end
  end
end
