class ConversationsController < ApplicationController
  before_action :authenticate_user! #authenticate before any action

  def index
    @users = User.all #to list all the registered users
    @conversations = Conversation.all
    	
  end

  def create
    if Conversation.between(params[:sender_id],params[:reciever_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:reciever_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    redirect_to conversation_messages_path(@conversation)
  end

  private
    def conversation_params
      params.permit(:sender_id, :reciever_id)
    end
end

#@conversations = Conversation.where("sender_id = ? OR reciever_id = ?", current_user.id, current_user.id)
    #@users = User.where.not(id: current_user.id)