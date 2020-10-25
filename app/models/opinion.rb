class Opinion < ApplicationRecord
  belongs_to :user
  validates_presence_of :text
  validates :text, length: { minimum: 1, maximum: 140 }
end
