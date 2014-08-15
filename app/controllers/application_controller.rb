class ApplicationController < ActionController::Base
	protect_from_forgery with: :null_session

	before_action :authenticate

	protected

	def current_user
		@current_user
	end

	private

	def authenticate
		authenticate_token || render_unauthorized
	end

	def authenticate_token
		authenticate_with_http_token do |token, options|
			@current_user = User.find_by_token(token)
		end
	end

	def render_unauthorized
		render json: { status: 'error', msg: 'bad credentials' }
	end
end
