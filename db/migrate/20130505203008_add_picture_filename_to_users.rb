class AddPictureFilenameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :picture_filename, :string
  end
end
