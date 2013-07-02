class AboutController < ApplicationController
	skip_before_filter :authorize, :only => [:trial_thankyou, :trial_action, :index, :more, :thankyou, :contact_action, :features, :pricing, :contact, :trial]
  layout 'about'
  	
	def index
	end

	def more
	end

	def pricing
	end

  def contact
  end

  def contact_action
    render action: "thankyou"
  end

  def thankyou
  end

  def trial
  end

  def trial_action
    render action: "trial_thankyou"
  end

  def trial_thankyou
  end

  def features
  end
  	
end
