class Channel < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :channel_users, dependent: :destroy
  has_many :users, through: :channel_users

  validates :name, presence: true

  after_commit -> { Turbo::StreamsChannel.broadcast_refresh_later_to("workspace") }
end
