class Api::V1::Games::ShotsController < ApiController
  def create
    game = Game.find(params[:game_id])

    shooting_player = User.find_by_api_key(request.headers["X-API-Key"])
    turn_processor = TurnProcessor.new(game, params[:shot][:target], shooting_player)

    if turn_processor.correct_player? && turn_processor.valid_spot?
      turn_processor.run!
      test = render json: game, message: turn_processor.message
    else
      render json: game, status: 400, message: turn_processor.message
    end
  end
end
