class Api::UserController < ApplicationController
	before_action :set_user, only: [:show, :update, :destroy]

	def show
		render json: { user: current_user }
	end

	def create
		@user = User.new(user_params)
		if @user.save
		  flash[:success] = "User successfully created"
		  redirect_to @user
		else
		  flash[:error] = "Something went wrong"
		  render 'new'
		end
	end

	def update
		@user = User.find(params[:id])
		@user.assign_attributes(user_params)
		if @user.changed?
			if @user.save
				flash[:success] = "User was successfully updated"
				redirect_to users_path
			else
				flash[:error] = "Something went wrong"
				render action: 'edit'
			end
		else
			flash[:info] = 'Nothing change'
			redirect_to users_path
		end
	end

	def destroy
		if @user.destroy
			flash[:success] = "User was successfully deleted"
			redirect_to users_path
		else
			flash[:error] = "Something went wrong"
			redirect_to users_path
		end
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

 	def user_params
		params[:user].permit(:need_ks1, :need_ks2, :need_ks3, :need_ks4, :need_ks5a, :need_ks5b, :need_ks6)
    end

end