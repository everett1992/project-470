# Abstract controller. Defines how controllers that handle dwellign items should behave
class DwellingItemsController < ApplicationController
	layout 'dwelling_layout'           # use the dwellign layout
	before_filter :load_upcoming_items # Load items to show in the sidebar
	before_filter :logged_in?          # Check that the user is logged in
end
