class TagsController < ApplicationController
	def suggestions
		tag_names = current_dwelling.tag_suggestions
		render json: tag_names, only: [:name, :id]
	end

end
