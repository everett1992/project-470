class Comment < Message
	# Relations
	belongs_to :dwelling_item, :polymorphic => true

	# Callbacks
	skip_callback :create, :after, :notify
end
