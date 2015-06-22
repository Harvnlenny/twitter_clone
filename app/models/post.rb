class Post < ActiveRecord::Base
  belongs_to :user
  validates :body, presence: true, length: { maximum: 140 }

  accepts_nested_attributes_for :user

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
      user_id: user.id)
  end
end
