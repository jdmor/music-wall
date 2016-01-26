class CreateReviewsTable < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :song, null: false
      t.references :user, null: false
      t.text :content, null: false
      t.timestamps null: false
    end
  end
end
