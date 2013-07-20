class ForgotPwdToken < ActiveRecord::Base
  attr_accessible :account_id, :token, :consumed

  def self.tokenexists(token)
  	ForgotPwdToken.where(:consumed => false).where('token = ? AND created_at > ?', "#{token}", Time.now - 1.days).first
  end

end
