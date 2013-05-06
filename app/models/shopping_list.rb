class ShoppingList < DwellingItem
	# Accessible Attributes
  attr_accessible :dwelling_id, :name

	# Relations
  has_many :shopping_list_items

	# Validations
  validates :name, :presence => true
end
