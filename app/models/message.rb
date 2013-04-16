class Message < DwellingItem
	# Accessible Attributes
  attr_accessible :body

	# Validations
  validates :body, :presence => true

	# Callbacks
	skip_callback :create, :after, :notify

	# Scopes
	scope :newest, order('created_at DESC')

end
