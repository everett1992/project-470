class Chore < DwellingItem
	# Accessible Attributes
  attr_accessible :assigned_user_id, :description, :dwelling_id, :name, :active, :cron_str

	# Relations
  belongs_to :assigned_user, :class_name => 'User'

	# Validations
  validates :name, :length => {:minimum => 1}
end
