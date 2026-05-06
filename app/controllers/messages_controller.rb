class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_channel
    before_action :require_membership

    def create
        @message = @channel.messages.create(message_params)
        @message.user = current_user
        @message.save

        render json: {}, status: :no_content
    end

    private

    def set_channel
        @channel ||= Channel.find(params[:channel_id])
    end

    def require_membership
        unless @channel.users.include?(current_user)
            render json: { error: "You must join this channel to send messages." }, status: :forbidden
        end
    end

    def message_params
        params.require(:message).permit(:content)
    end
end
