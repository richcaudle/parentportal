module ApplicationHelper
	def is_logged_in
		!(session[:user_id].nil?)
	end

	def is_superuser
		if UserRole.find_by_user_id_and_role_id(session[:user_id], 1)
			return true
		else
			return false
		end
	end
end
