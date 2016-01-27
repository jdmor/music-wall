class Review < ActiveRecord::Base
  belongs_to :song
  belongs_to :user

  validates :song_id, presence: true, uniqueness: { scope: :user_id,
    message: 'can only be reviewed once per user'}
  validates :user_id, presence: true
  validates :content, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 6 }
end