class Notification < Message
	# Relations
	belongs_to :dwelling_item, :polymorphic => true

	# Validations
  validates :dwelling_item_id, :dwelling_item_type, :presence => true
end
