require 'rails_helper'

RSpec.describe "Channels", type: :request do
  let(:user) { create(:user) }
  let!(:channel) { create(:channel) }

  describe "GET /channels" do
    context "when authenticated" do
      before do
        login_as(user)
        get channels_path
      end

      it "returns a successful response" do
        expect(response).to be_successful
      end

      it "displays the channels" do
        expect(response.body).to include(channel.name)
      end
    end

    context "when not authenticated" do
      it "redirects to sign in" do
        get channels_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /channels/:id" do
    context "when authenticated" do
      before do
        login_as(user)
        create(:channel_user, user: user, channel: channel)
        get channel_path(channel)
      end

      it "returns a successful response" do
        expect(response).to be_successful
      end

      it "displays the channel name" do
        expect(response.body).to include(channel.name)
      end
    end
  end

  describe "POST /channels" do
    context "when authenticated" do
      before do
        login_as(user)
      end

      it "creates a new channel and redirects to it" do
        expect {
          post channels_path, params: { channel: { name: "new-channel" } }
        }.to change(Channel, :count).by(1)

        expect(response).to redirect_to(channel_path(Channel.last))
      end
    end
  end
end
