class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
   def logged_in?
    if session[:int_key].nil? || session[:email].nil? || session[:password].nil? || session[:logged_in].nil?
      false
    else
      true
    end
end
end
