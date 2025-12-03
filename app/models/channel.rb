class Channel < ApplicationRecord
  has_many :messages
  has_many :channel_users, dependent: :destroy
  has_many :users, through: :channel_users

  validates :name, presence: true
end
