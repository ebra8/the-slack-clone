class ChannelUser < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  # after_create :broadcast_members
  # def broadcast_members
  #   broadcast_append_to(
  #     [ channel, "users" ],
  #     target: "channel_members",
  #     partial: "users/user",
  #     locals: { user: user }
  #   )
  # end
end
