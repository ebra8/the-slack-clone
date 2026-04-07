require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }

  describe "POST /channels/:channel_id/messages" do
    context "when authenticated" do
      before do
        login_as(user)
      end

      it "creates a new message" do
        expect {
          post channel_messages_path(channel), params: { message: { content: "Hello Chat!" } }
        }.to change(Message, :count).by(1)
        
        expect(Message.last.content).to eq("Hello Chat!")
        expect(Message.last.user).to eq(user)
        expect(Message.last.channel).to eq(channel)
      end

      it "returns no content status" do
        post channel_messages_path(channel), params: { message: { content: "Turbo test" } }
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when not authenticated" do
      it "does not create a message and redirects" do
        expect {
          post channel_messages_path(channel), params: { message: { content: "Hello Chat!" } }
        }.not_to change(Message, :count)
        
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
