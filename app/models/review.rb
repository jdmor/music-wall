class Review < ActiveRecord::Base
  belongs_to :song
  belongs_to :user

  validates :song_id, presence: true, uniqueness: { scope: :user_id,
    message: 'can only be reviewed once per user'}
  validates :user_id, presence: true
  validates :content, presence: true
end