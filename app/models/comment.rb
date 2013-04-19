class Comment < Message
	# Relations
	belongs_to :dwelling_item, :polymorphic => true
end
