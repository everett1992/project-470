class Group < ActiveRecord::Base
	has_many :bills
	has_many :chores
	has_many :shopping_lists
	has_many :events

	def all
		return []
			.concat(self.bills)
			.concat(self.chores)
			.concat(self.shopping_lists)
			.concat(self.events)
	end
end
