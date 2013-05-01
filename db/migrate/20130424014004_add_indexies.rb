class AddIndexies < ActiveRecord::Migration
	def change
		add_index :chores, :assigned_user_id
		add_index :chores, :dwelling_id
		add_index :messages, :dwelling_id
		add_index :messages, :dwelling_item_id
		add_index :messages, :dwelling_item_type
		add_index :shopping_list_items, :shopping_list_id
		add_index :shopping_lists, :dwelling_id
	end
end
