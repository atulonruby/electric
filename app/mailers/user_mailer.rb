class UserMailer < ActionMailer::Base
  default :to => "info@electricoak.com" 
   def registration_confirmation(msg)
     @message = msg
     mail( :subject => "Contact from ElectricOak Site", :from => default_from(msg), :cc => mail_list)
   end
   
   :private
   def mail_list
     "atuljha86@gmail.com, alec.myring@gmail.com, bobgecs@gmail.com, godfrey.ben@gmail.com"
   end
   
   def default_from(msg)
     msg.email.blank? ? "eletricoak.com" : msg.email
   end
end
