class CommentsController < DwellingItemsController
	before_filter :get_dwelling_item_and_comment

	def show
	end

	def create
		@comment = @dwelling_item.comments.create(params[:comment])
		@comment.dwelling = @dwelling_item.dwelling
		@comment.owner = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@dwelling_item], notice: 'Comment was successfully created.' }
      else
        format.html { render :new }
      end
		end
	end

	private

	# Assign @dwelling, @dwelling_item and @comments if applicable
	# dwelling_item can be any type of dwelling item
	# comments are then loaded from the dwelling_item
	def get_dwelling_item_and_comment
		@dwelling = current_dwelling
		# Bills
		if params[:bill_id]
			@dwelling_item = @dwelling.bills.find(params[:bill_id])

		# Shopping Lists
		elsif params[:shopping_list_id]
			@dwelling_item = @dwelling.shopping_lists.find(params[:shopping_list_id])

		# Chores
		elsif params[:chore_id]
			@dwelling_item = @dwelling.chores.find(params[:chore_id])

		# Events
		elsif params[:event_id]
			@dwelling_item = @dwelling.events.find(params[:event_id])

		# Comments
		elsif params[:comment_id]
			@dwelling_item = @dwelling.comments.find(params[:comment_id])

		# Posts
		elsif params[:post_id]
			@dwelling_item = @dwelling.posts.find(params[:post_id])

		end

		if params[:id]
			if @dwelling_item
				@comment = @dwelling_item.comments.find(params[:id])
			else
				@comment = @dwelling.comments.find(params[:id])
			end
		end
	end
end
