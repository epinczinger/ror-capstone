class Opinion < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates_presence_of :text
  validates :text, length: { minimum: 1, maximum: 140 }
end
