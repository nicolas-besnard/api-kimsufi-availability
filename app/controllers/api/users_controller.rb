class Api::UsersController < ApplicationController

	before_action :set_user, only: [:show, :update]
	before_action :check_user_param

	skip_before_filter :authenticate, only: :create

	def index
		if current_user
			render json: { user: current_user }
		else
			render json: { status: 'unknown_user', msg: 'user not registered' }
		end
	end

	def create
		if @user = User.find_by(token: user_params_token[:token])
			render json: { status: 'ok', user: @user }
		else
			@user = User.new(user_params_token)
			if @user.save
				render json: { status: 'ok', msg: 'User was successfully created', user: @user }
			else
				render json: { status: 'error', msg: 'Something went wrong' }
			end
		end
	end

	def update
		current_user.assign_attributes(user_params)
		if current_user.changed?
			if current_user.save
				render json: { status: 'ok', user: current_user }
			else
				render json: { status: 'error', msg: 'Can\'t update User' }
			end
		else
			render json: { status: 'ok', user: current_user }
		end
	end

	def destroy
		if params.has_key?(:id) && current_user.id == params[:id].to_i
			if current_user.destroy
				render json: { status: 'ok', msg: 'User was successfully deleted' }
			else
				render json: { status: 'error', msg: 'Something went wrong' }
			end
		else
			render json: { status: 'error', msg: 'Missing parameters' }
		end
	end

	private

	def check_user_param
		if !params.has_key?(:user)
			render json: { status: 'error', msg: 'Missing parameters' }
		end
	end

	def set_user
		@user = User.find_by(id: params[:id])
	end

	def user_params
		params[:user].permit(:id, :need_ks1, :need_ks2, :need_ks3, :need_ks4, :need_ks5a, :need_ks5b, :need_ks6)
	end

	def user_params_token
		params[:user].permit(:token)
	end

end