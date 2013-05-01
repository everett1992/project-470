class AddTopicArnColumnToDwelling < ActiveRecord::Migration
  def change
		change_table :dwellings do |t|
			t.string :topic_arn
		end
  end
end
