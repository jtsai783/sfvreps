require 'tripcode'
require 'rest-client'

class CommentsController < ApplicationController
	def new
		@name = params[:player_id]
	end

	def create
		rating = params[:rating]
		player_name = params[:player_id]
		comment = params[:comment]
		author = params[:author]
		tripcode = Tripcode.secure(params[:tripcode], Rails.application.secrets.trip_secret)
		captcha_res = params["g-recaptcha-response"]
		google_res = JSON.parse(RestClient.post(
			'https://www.google.com/recaptcha/api/siteverify',
			:secret => Rails.application.secrets.recaptcha_key,
			:response => captcha_res
			))

		if google_res["success"] == true
			player = Player.find_by_name(player_name)
			if player.nil?
				player = Player.create(:name => player_name)
			end
			comment = Comment.create(:comment => comment, :player_id => player.id,
				:rating => rating.to_i, :byline => author, :tripcode => tripcode
				)
			redirect_to player_url(player_name)
		end
	end
end
