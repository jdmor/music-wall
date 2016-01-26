class ChangeUsersColInSongs < ActiveRecord::Migration
  def up
    change_table :songs do |t|
      t.rename :users_id, :user_id
    end
  end

  def down
    change_table :songs do |t|
      t.rename :user_id, :users_id
    end
  end
end
