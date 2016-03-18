class PlayersController < ApplicationController
	def index
		player_name = params["player-name"]
		redirect_to action: "show", id: player_name
	end

	def show
		@name = params[:id]
		@comments = []
		player = Player.find_by_name(@name)
		if !player.nil?
			@comments = Comment.where(player_id: player.id).order(created_at: :DESC)
		end
	end
end
