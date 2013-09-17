class UserMailer < ActionMailer::Base
  default :to => "atuljha86@gmail.com" 
   def registration_confirmation(msg)
     @message = msg
     mail( :subject => "Contact from ElectricOak Site", :from => "ajvictoria03@gmail.com")
   end
end
