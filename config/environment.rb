# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Parentportal::Application.initialize!

# Sendgrid details
ActionMailer::Base.smtp_settings = {
  :address => "smtp.sendgrid.net",
  :port => 25,
  :domain => "",
  :authentication => :plain,
  :user_name => "",
  :password => ""
}

