class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private #Se establece el Metodo acá porque lo necesitamos en varios Controladores
   # Confirms a logged-in user.
   def logged_in_user
     unless logged_in?
       store_location
       flash[:danger] = "Please log in."
       redirect_to login_url
     end
   end

end
