class RevealsController < ApplicationController
  def show
    @player = Player.from_param(params[:id])
    if @player.revealed_at.present?
      @reveal = false
    else
      @player.update!(revealed_at: Time.zone.now)
      @reveal = true
    end
  end
end
