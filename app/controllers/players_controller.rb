class PlayersController < ApplicationController
  def show
    @player = Player.from_param(params[:id])
  end

  def update
    @player = Player.from_param(params[:id])
    redirect_to reveal_path(@player)
  end
end
