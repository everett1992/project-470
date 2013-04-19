class AddGroupTables < ActiveRecord::Migration
	def change
		create_table :groups do |t|
		end

		[:messages, :bills, :events, :shopping_lists, :chores].each do |table|
			add_column table, :group_id, :integer
		end
	end
end
