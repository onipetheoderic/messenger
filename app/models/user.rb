class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	def full_name
	  [surname, last_name].join(' ')
	end

	def full_name_or_email #if fullname is greater than 4 characters display the name
		if full_name.length > 3 || full_name.length == 3
			full_name.titleize #to capitalize the first word of each field
		else
			email
		end
	end
end


 # def name
 #    "#{first_name} #{last_name}"
 #  end