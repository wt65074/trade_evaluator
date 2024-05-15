# typed: true

class TradesController < ApplicationController
  def show
    @models = ValueModel.all
    @picks_by_team = PicksByTeamAndSeason.where(season: 2024)
    @all_picks = @picks_by_team.flat_map(&:picks).sort

    @trade = if params[:id].nil?
               Trade.new
             else
               Trade.find(params[:id]).dup

             end
  end

  def new
    @models = ValueModel.all
    @picks_by_team = PicksByTeamAndSeason.where(season: 2024)
    @all_picks = @picks_by_team.flat_map(&:picks).sort
    puts @all_picks
    @trade = if params[:id].nil?
               Trade.new
             else
               Trade.find(params[:id]).dup

             end
    render :show
  end

  def index
    @trades = Trade.all.order('created_at DESC')
    @models = ValueModel.all
  end

  def create
    trade = Trade.new(trade_params)
    if trade.save
      redirect_to trade, notice: 'Trade Saved'
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    trade = Trade.find(params[:id])
    trade.destroy
    redirect_to :trades
  end

  private

  def trade_params
    # pretty sure this aint best practice
    params[:trade][:team_a_picks] = params[:trade][:team_a_picks].map(&:to_i)
    params[:trade][:team_b_picks] = params[:trade][:team_b_picks].map(&:to_i)
    params.require(:trade).permit(:team_a, :team_b, team_a_picks: [], team_b_picks: [])
  end
end
