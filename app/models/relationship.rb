class Relationship < ActiveRecord::Base
  belongs_to :follower
  belongs_to :followed
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
