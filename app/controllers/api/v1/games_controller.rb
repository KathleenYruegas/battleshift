module Api
  module V1
    class GamesController < ActionController::API
      def show
        game = Game.find_by_id(params[:id])
        if game
         render json: game
        else
         render status: 400
       end
      end

      def create
        player_1 = User.find_by_api_key(request.env["HTTP_X_API_KEY"])
        player_2 = User.find_by_email(params[:opponent_email])

        game_attributes = { player_1_board: Board.new(4),
                            player_2_board: Board.new(4),
                            player_1: player_1,
                            player_2: player_2
                          }
        game = Game.new(game_attributes)
        game.save

        render json: game
      end
    end
  end
end
