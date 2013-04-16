class Chore < DwellingItem
	# Accessible Attribuets
  attr_accessible :assigned_user_id, :description, :dwelling_id, :name

	# Relations
  belongs_to :assigned_user, :class_name => 'User'

	# Validations
  validates :name, :length => {:minimum => 1}
end
