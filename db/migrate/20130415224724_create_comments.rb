class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
			t.references :dwelling
			t.integer    :owner_id
			t.integer    :dwelling_item_id
			t.string    :dwelling_item_type
			t.text       :body

      t.timestamps
    end
  end
end
