class Admin::MessagesController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  def index
    @messages = Message.by_user_id
  end

  def new
    @message = Message.new
  end

  def show
    @message = Message.new
    @user = User.find (Message.find params[:id]).user_id
    Message.where("user_id = ?", @user.id).update_all(admin_read: 0)
    @messages = Message.where("user_id = ?", @user.id).last(20)
  end

  def create
    @message = Message.new message_params
    if @message.save
      redirect_to admin_message_path(@message), notice: "Сообщение отправлено!"
    else
      render :new
    end
  end

  def destroy
    @message = Message.find params[:id]
    @message.destroy
    redirect_to admin_messages_path, notice: "Сообщение удалено!"
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :message, :author_id)
  end
  
end
