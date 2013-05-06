class Event < DwellingItem
	# Accessible Attributes
  attr_accessible :date, :description, :name

	# Validations
  validates :name, :presence => true
  validates :description, :presence => true

  validates :date, :presence => true

	# Scopes

	# get the four next events
	scope :upcoming, order(:date).where(['date >= ?', Date.today])
	scope :past, order('date DESC').where(['date < ?', Date.today()])
end
