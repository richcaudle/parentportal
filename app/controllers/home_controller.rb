class HomeController < ApplicationController
  skip_before_filter :authorize, :only => [:index]

  def index
  	@children = Child.my_children(session[:user_id])
  end
  
end
