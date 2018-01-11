class Conversation < ApplicationRecord
	belongs_to :sender, class_name: "User", foreign_key: "sender_id"
	belongs_to :reciever, class_name: "User", foreign_key: "reciever_id"
	has_many :messages, dependent: :destroy
	#We're also going to add a validation as well. We want to make sure that only one conversation 
	#is created between two users, regardless of who is the receiver and who is the sender
	validates_uniqueness_of :sender_id, scope: :reciever_id
	#Finally, we need to add a class method -->between --which will allow us to find the conversation between two users, 
	#regardless of who is the sender and who is the receiver. To create a class method with ActiveRecord, 
	#we use the scope keyword method.
	scope :between, -> (sender_id,reciever_id) do
		where("(conversations.sender_id = ? AND conversations.reciever_id = ?) OR 
			(conversations.sender_id = ? AND conversations.reciever_id = ?)", sender_id, reciever_id, reciever_id, sender_id)
	end #we try to find the one that has either one as a sender or as a reciever, it takes two arguments, the sender_id, reciever_id,
	#and save it where the two exists
	def recipient(current_user)
		self.sender_id == current_user.id ? self.reciever : self.sender
	end
	def unread_msg(current_user)
		self.messages.where("user_id != ? AND read = ?", current_user.id, false).count
	end
end

# A conversation has many messages, and when you destroy the message the conversation is destroyed
#If you wrote an application tracking messages between individuals (lets call it conversation)
# you might have a table called Conversation and in that table you’d need to track the sender and the reciever.
# Both Sender and Reciever should be objects from the users table, so as to be unique,
# and we’ve got two columns that refer to them: sender_id and reciever_id.

#belongs_to :user --> when we do this, ActiveRecord derives the class_name by camelarizing it to User --> the Assumed classname
#if it was a has_many it would be singularized. e.g has_many users would become Users, then the classname becomes User
#but when you specify the Class_name: User, this takes more priority,
#so this is why we specified the classname--->
	#1. to make sure that sender is not converted to Sender, 
	#2. we specify that we are not getting the foreign key from the conversation model but from the User model

	#so the :sender is just a custom name of the association between the User and the sender_id
	#the sender_id is a foriegn key in the User model, so you can now access this association by saying
	#conversation.sender
	#conversation.reciever
#Here, we've indicated that the sender_id and receiver_id are both ids from the user table. 
#So when we do conversation.sender or conversation.receiver, ActiveRecord will attempt to find a user with those ids.

#You don’t actually need the foreign key in this case (since the default is association name + _id (from rails 2.0)
#so this simplifies down to

 # belongs_to :sender, :class_name => 'User'
  #belongs_to :reciever, :class_name => 'User'
  #we only declare the foreign key to make it explicit

