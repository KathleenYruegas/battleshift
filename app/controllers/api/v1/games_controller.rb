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
        player_1 = User.find_by_api_key(request.headers["X-API-Key"])
        player_2 = User.find_by_email(params[:opponent_email])

        render json: Game.create(game_attributes(player_1, player_2))
      end

      private

      def game_attributes(player_1, player_2)
        { player_1_board: Board.new(4),
          player_2_board: Board.new(4),
          player_1_id: player_1.id,
          player_2_id: player_2.id
        }
      end
    end
  end
end
