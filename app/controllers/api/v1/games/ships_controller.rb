class Api::V1::Games::ShipsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])

    player_1_ships = ShipPlacer.new(ship_1_attributes)
    player_1_ships.run

    player_2_ships = ShipPlacer.new(ship_2_attributes)
    player_2_ships.run

    @game.save

    render json: @game, message: player_1_ships.message(params[:ship_size])
  end

  private

  def ship_1_attributes
    { board: @game.player_1_board,
      ship: Ship.new(params[:ship_size]),
      start_space: params[:start_space],
      end_space: params[:end_space]
    }
  end

  def ship_2_attributes
    { board: @game.player_2_board,
      ship: Ship.new(params[:ship_size]),
      start_space: params[:start_space],
      end_space: params[:end_space]
    }
  end
end
