class ChannelUser < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  after_commit -> { Turbo::StreamsChannel.broadcast_refresh_later_to("workspace") }
end
