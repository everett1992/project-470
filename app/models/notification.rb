class Notification < Message
	# Relations
	belongs_to :dwelling_item, :polymorphic => true

	after_create :publish_to_sns

	# Validations
  validates :dwelling_item_id, :dwelling_item_type, :presence => true

	private

	def publish_to_sns
		dwelling.topic.publish( "#{owner.name} #{body} #{dwelling_item.class}.",
													 :subject => "Roomie Notification",
													 :email => " Roomie Notification:\n #{owner.name} #{body} #{dwelling_item.class} "
													)
	end
end
