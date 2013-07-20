class AddConsumedToForgotPwdToken < ActiveRecord::Migration
  def change
    add_column :forgot_pwd_tokens, :consumed, :boolean
  end
end
