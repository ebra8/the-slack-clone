require 'rails_helper'

RSpec.describe ChannelUser, type: :model do
  describe "associations" do
    it "belongs to user" do
      expect(ChannelUser.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "belongs to channel" do
      expect(ChannelUser.reflect_on_association(:channel).macro).to eq(:belongs_to)
    end
  end

  describe "callbacks" do
    it "broadcasts members after create" do
      channel_user = build(:channel_user)
      expect(channel_user).to receive(:broadcast_append_to).with(
        [ channel_user.channel, "users" ],
        target: "channel-members",
        partial: "users/user",
        locals: { user: channel_user.user }
      )
      channel_user.save
    end

    it "broadcasts members removal after destroy" do
      channel_user = create(:channel_user)
      expect(channel_user).to receive(:broadcast_remove_to).with(
        [ channel_user.channel, "users" ],
        target: "user_#{channel_user.user.id}"
      )
      channel_user.destroy
    end
  end
end
