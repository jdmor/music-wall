class Upvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  validates :song_id, presence: true
  validates :user_id, presence: true
  validate :user_can_upvote

  def user_can_upvote
    errors.add(:user_can_upvote, 'a song only once.') if Upvote.find_by song_id: song_id, user_id: user_id
  end
end