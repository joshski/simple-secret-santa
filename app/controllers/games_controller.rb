class GamesController < ApplicationController
  def new
    @game = Game.new
    10.times { @game.players.build }
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to @game
    else
      render :new
    end
  end

  def show
    @game = Game.from_param(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(players_attributes: [:name])
  end
end
