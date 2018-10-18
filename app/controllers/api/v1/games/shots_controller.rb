class Api::V1::Games::ShotsController < ApiController
  def create
    game = Game.find(params[:game_id])

    shooting_player = User.find_by_api_key(request.headers["X-API-Key"])

    if shooting_player && (shooting_player == game.player_1 || shooting_player == game.player_2)
      turn_processor = TurnProcessor.new(game, params[:shot][:target], shooting_player)
      if turn_processor.valid_turn?
        turn_processor.run!
        render json: game, message: turn_processor.message
      else
        render json: game, status: 400, message: turn_processor.message
      end
    else
      render json: {message: "Unauthorized"}, status: 401
    end
  end
end
