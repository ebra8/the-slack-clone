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
    it "broadcasts a workspace refresh after commit" do
      channel_user = build(:channel_user)
      expect(Turbo::StreamsChannel).to receive(:broadcast_refresh_later_to).with("workspace").at_least(:once)
      channel_user.save
    end
  end
end
