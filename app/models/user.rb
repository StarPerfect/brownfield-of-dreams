# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def bookmarks
    Tutorial.includes(videos: :user_videos)
            .where(user_videos: {user_id: self.id})
  end

  def friendships?
    friendships.count.positive?
  end

  def friends?(github_user)
    friend = User.find_by(github_uid: github_user.uid)
    friends.include?(friend)
  end
end
