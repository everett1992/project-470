class ChangeEventTitleToName < ActiveRecord::Migration
	def change
		rename_column :events, :title, :name
		rename_column :shopping_lists, :title, :name
	end
end
