require 'securerandom'

class AccountController < ApplicationController
  skip_before_filter :authorize, :only => [:forgotpassword, :forgotpassword_sent, :forgotpassword_action, :forgotpassword_return, :forgotpassword_update, :forgotpassword_updateaction, :register, :register_action, :login, :login_action, :logout]
  append_before_filter :filter_anonymous, :only => [:forgotpassword, :forgotpassword_sent, :forgotpassword_action, :forgotpassword_return, :forgotpassword_update, :forgotpassword_updateaction, :register, :register_action, :login, :login_action]
  
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
    render :layout => 'about'
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

  # GET /account/updatepassword
  def forgotpassword
    
  end

  def forgotpassword_action
    usr = User.find_by_email(params[:email])

    if usr

      # Store random token for account
      tkn = ForgotPwdToken.new
      tkn.token = SecureRandom.hex(20)
      tkn.account_id = usr.id
      tkn.consumed = false
      tkn.save

      AccountMailer.forgotpassword(usr, tkn).deliver

      render action: "forgotpassword_sent"

    else
      redirect_to forgotpassword_url, notice: 'The email address was not found on our system'
    end
  end

  def forgotpassword_sent
    
  end
  
  def forgotpassword_return
    tkn = ForgotPwdToken.tokenexists(params[:token])

    if tkn
      @user = User.find_by_id(tkn.account_id)
      render action: "forgotpassword_updateaction"

      tkn.consumed = true
      tkn.save
    else
      redirect_to forgotpassword_url, notice: 'The link you used has expired, please try again by using the form below'
    end
  end

  def forgotpassword_updateaction

  end

  def forgotpassword_update
    @user = User.find(params[:user_id])

    if @user.update_attributes(params[:user])
      redirect_to home_url, notice: 'Password updated successfully'
    else
      render action: "forgotpassword_updateaction"
    end
  end

    
end
