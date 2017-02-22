class MessagesController < ApplicationController

  before_action :authenticate_user!

  def index
    current_user.messages.update_all(user_read: 0)
    @messages = current_user.messages.last(20)
    @message = Message.new
  end

  def create
    @message = current_user.messages.build message_params
    if @message.save
      redirect_to messages_path, notice: "Сообщение отправлено!"
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:message, :author_id)
  end

end
