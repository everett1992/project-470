class AddCronToChores < ActiveRecord::Migration
  def change
    add_column :chores, :active, :boolean
    add_column :chores, :cron_str, :string
  end
end
