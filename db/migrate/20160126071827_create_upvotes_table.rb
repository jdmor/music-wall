class CreateUpvotesTable < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.references :user, null: false
      t.references :song, null: false
      t.timestamps null: false
    end
  end
end
