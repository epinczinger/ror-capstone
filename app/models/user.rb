class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :opinions, dependent: :destroy
  has_many :active_followings, class_name: 'Following', foreign_key: 'follower_id', dependent: :destroy
  has_many :pasive_followings, class_name: 'Following', foreign_key: 'followed_id', dependent: :destroy

  has_many :followings, through: :active_followings, source: :followed
  has_many :followers, through: :pasive_followings, source: :follower

  has_one_attached :photo
  has_one_attached :cover_image

  has_many :likes, dependent: :destroy

  validates_uniqueness_of :username, case_sensitive: false
  validates_presence_of :username
  validates_presence_of :fullname
  validates :username, length: { minimum: 5, maximum: 15 }
  validates :fullname, length: { minimum: 5, maximum: 25 }

  scope :with_photos, -> { includes(:photo_attachment, :cover_image_attachment) }

  def follow(other)
    active_followings.create(followed_id: other.id)
  end

  def unfollow(other)
    active_followings.find_by(followed_id: other.id).destroy
  end

  def following?(other)
    followings.include?(other)
  end

  def not_following
    User.where.not(id: followings).where.not(id: id).order('created_at DESC')
  end
end
