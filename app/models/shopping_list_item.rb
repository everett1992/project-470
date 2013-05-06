class ShoppingListItem < ActiveRecord::Base
	# Relations
  belongs_to :shopping_list
	# Accessible Attributes
  attr_accessible :name, :obligate_id, :obligates, :quantity, :shopping_list_id, :status

	# Validations
  validates :name, :presence => true
end
