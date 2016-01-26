class Song < ActiveRecord::Base
  belongs_to :user
  has_many :upvotes
  has_many :reviews

  validates :title, presence: true
  validates :author, presence: true
    
end