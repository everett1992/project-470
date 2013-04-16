class DwellingItem < ActiveRecord::Base
	# This class defines a protocol, and cannot be instantiated.
	self.abstract_class = true

	# Relations
  belongs_to :dwelling
  belongs_to :owner, :class_name => 'User'

	has_many :comments, :as => :dwelling_item

	# Validations
  validates :dwelling, :presence => true
  validates :owner, :presence => true

	# Filter
	after_create :notify

	def notify
		notification = self.dwelling.notifications.build(
			body: "created a new"
		)
		notification.dwelling_item = self
		notification.owner = self.owner
		notification.save
	end
end
