class MessagesController < ApplicationController
	
	before_action do 
		@conversation = Conversation.find(params[:conversation_id]) #to get the current conversation
	end

	def index
		@messages = @conversation.messages
		
		
  		if @messages.length > 10
   			@over_ten = true
   			@messages = @messages[-10..-1]
  		end
  		
  		if params[:m]
   		@over_ten = false
   		@messages = @conversation.messages
  		end

 		if @messages.last #meaning if the last message, which is the one sent to you, is not your own, then mark is as read
 			if @messages.last.user_id != current_user.id
	  			@messages.last.read = true
	  			@messages.where(:read => false).update_all(:read => true)
	  		end
	 	end

	@message = @conversation.messages.new
 	end

	def new
 		@message = @conversation.messages.new

	end

	def create
		@message = @conversation.messages.new(message_params)
	 	if @message.save
	 		@message.read = false
	  		redirect_to conversation_messages_path(@conversation)
	  		
	 	end
	end

private
 def message_params
  params.require(:message).permit(:body, :user_id, :read)
 end
end
	# def index
	# 	@messages = @conversation.messages #to pull the msg from the current conversation
	# 	#we filter it to where the 1. msg is not created by the user, 2.read is false since all the messages would be on the page 
	# 	#we can then assume that the user has read all the msgs so we use the update_all(read: true)
 #    	@messages.where("user_id != ? AND read = ?", current_user.id, false).update_all(read: true)
 #    	@message = @conversation.messages.new
 #  	end

 #  	def create
 #  		@message = @conversation.messages.new(message_params)
 #  		@message.user = current_user

 #  		if @message.save
 #  			redirect_to conversation_messages_path(@conversation)
 #  		end
 #  	end

 #  	private

 #  	def message_params
 #  		params.require(:message).permit(:body, :user_id)
 #  	end

