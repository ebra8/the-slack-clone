require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "associations" do
    it "belongs to user" do
      expect(Message.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "belongs to channel" do
      expect(Message.reflect_on_association(:channel).macro).to eq(:belongs_to)
    end
  end

  describe "validations" do
    it "is valid with content" do
      expect(build(:message)).to be_valid
    end

    it "is not valid without content" do
      expect(build(:message, content: nil)).not_to be_valid
    end
  end

  describe "callbacks" do
    it "calls broadcast_append_to after create" do
      message = build(:message)
      expect(message).to receive(:broadcast_append_to).with(
        [ message.channel, "messages" ],
        target: "messages",
        partial: "messages/message",
        locals: { message: message }
      )
      message.save
    end
  end
end
