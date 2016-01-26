class AddUserIdColToSongs < ActiveRecord::Migration
  def up
    add_reference :songs, :users
  end

  def down
    remove_reference :songs, :users
  end
end
