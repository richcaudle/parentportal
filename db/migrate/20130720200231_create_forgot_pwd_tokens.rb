class CreateForgotPwdTokens < ActiveRecord::Migration
  def change
    create_table :forgot_pwd_tokens do |t|
      t.integer :account_id
      t.string :token

      t.timestamps
    end
  end
end
