class AddTypeColumnToMessage < ActiveRecord::Migration
  def change
		change_table :messages do |t|
			t.string :type
		end
  end
end
