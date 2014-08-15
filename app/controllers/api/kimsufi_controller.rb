class Api::KimsufiController < ApplicationController
	def index
		render json: { status: 'ok', msg: '' }
	end
end
