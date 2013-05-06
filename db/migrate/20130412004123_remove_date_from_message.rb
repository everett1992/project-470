class RemoveDateFromMessage < ActiveRecord::Migration
  def up
		remove_column :messages, :date
  end

  def down
		change_table :messages do |t|
			t.date :date
		end
		Message.all do |message|
			message.update_attributes!(date: message.created_at)
		end
  end
end
