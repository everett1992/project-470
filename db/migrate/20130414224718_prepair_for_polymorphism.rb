class PrepairForPolymorphism < ActiveRecord::Migration
	def change
		add_column :bills, :owner_id, :integer
		add_column :chores, :owner_id, :integer
		add_column :shopping_lists, :owner_id, :integer
		add_column :shopping_list_items, :owner_id, :integer

		rename_column :events, :user_id, :owner_id
		rename_column :messages, :user_id, :owner_id
	end
end
