class ApplicationController < ActionController::Base
  before_filter :authorize
  protect_from_forgery

  layout 'default'
  
  protected
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, :notice => "Please log in"
      end 
    end

    def filter_anonymous
      if User.find_by_id(session[:user_id])
        redirect_to home_url
      end 
    end

    def filter_superuser
      unless UserRole.find_by_user_id_and_role_id(session[:user_id], 1)
        redirect_to home_url
      end 
    end

end
