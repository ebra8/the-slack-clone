class ChannelUser < ApplicationRecord
  belongs_to :channel
  belongs_to :user
  after_create :broadcast_members
  after_destroy :remove_broadcast_members

  def broadcast_members
    broadcast_append_to(
      [ channel, "users" ],
      target: "channel-members",
      partial: "users/user",
      locals: { user: user }
    )
  end

  def remove_broadcast_members
    broadcast_remove_to(
      [ channel, "users" ],
      target: "user_#{user.id}"
    )
  end
end
