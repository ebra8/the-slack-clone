class Message < ApplicationRecord
  belongs_to :channel
  belongs_to :user
  validates :content, presence: true
  after_create :broadcast_message

  def broadcast_message
    broadcast_append_to(
      [ channel, "messages" ],
      target: "messages",
      partial: "messages/message",
      locals: { message: self }
    )
  end
end
