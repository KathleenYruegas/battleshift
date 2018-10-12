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
        user_1 = User.find_by_api_key(params[:api_key])
        user_2 = User.find_by_email(params[:opponent_email])
        player_1_board = Board.new(10)
        player_2_board = Board.new(10)
        user_1 = Player.new(player_1_board)
        player_2 = Player.new(player_2_board)
        render json: Game.create(player_1_board: player_1_board, player_2_board: player_2_board)
      end
    end
  end
end
