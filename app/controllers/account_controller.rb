class AccountController < ApplicationController
  skip_before_filter :authorize, :only => [:register, :register_action, :login, :login_action, :logout]
  append_before_filter :filter_anonymous, :only => [:register, :register_action, :login, :login_action]

  # GET /account/register
  def register
    @user = User.new
  end

  def register_action
    @user = User.new(params[:user])

    if @user.save
      redirect_to home_url, notice: 'Registration successful'
    else
      render action: "register"
    end
  end

  def login
  	@user = User.new
  end

  def login_action
  	 if user = User.authenticate(params[:user][:email], params[:user][:password])
        session[:user_id] = user.id
        redirect_to home_url, :notice => "Successful login"
	   else
		    redirect_to login_url, :notice => "Invalid user & password combination"
	   end
  end

  def logout
	   session[:user_id] = nil
	   redirect_to home_url, :notice => "Logged out"
  end

  # GET /account/updatepassword
  def updatepassword
    @user = User.new
  end

  def updatepassword_action
    @user = User.find(session[:user_id])

    if @user.update_attributes(params[:user])
      redirect_to home_url, notice: 'Password update successful'
    else
      render action: "updatepassword"
    end
  end
  
end
