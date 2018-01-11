class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  #we are just going to add validation to it to ensure all the fields are filled in.
  validates_presence_of :body, :conversation_id, :user_id

  #While we're here, we can add some formatting to the timestamp,
  # so we can display the time of the message in a more human readable way:

  profanity_filter :body #to filter out bad words using the profanity filter gem, very easy to implement
  def message_time
  	created_at.strftime("%d/%m/%y at %l:%M %p")
  end


end
