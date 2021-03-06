class SessionsController < ApplicationController

	def show
		if current_user.present?
			redirect_to tweets_path
		end
	end

	def create
		auth = request.env["omniauth.auth"]
		user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
		session[:user_id] = user.id
		redirect_to tweets_path, :notice => "Sucessfully Signed In"

	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path, :notice => "Sucessfully Signed Out"
	end
end
