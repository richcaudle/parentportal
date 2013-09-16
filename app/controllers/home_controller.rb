class HomeController < ApplicationController
  skip_before_filter :authorize, :only => [:index]

  def index
  	@areas = LearningArea.all
  	@children = Child.my_children(session[:user_id])
      .includes(:entries).where("entries.deleted" => false)
  end
  
end
