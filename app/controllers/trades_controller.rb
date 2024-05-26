# typed: true

class TradesController < ApplicationController
  def show
    @models = ValueModel.all
    @teams = Team.all
    @all_picks = DraftPick.all
    @picks_by_team = @all_picks.group_by(&:team)
    @trade = if params[:id].nil?
               Trade.new
             else
               Trade.find(params[:id]).dup

             end

    render layout: 'content'
  end

  def new
    @models = ValueModel.all
    @teams = Team.all
    @all_picks = DraftPick.all
    @picks_by_team = @all_picks.group_by(&:team)
    @trade = if params[:id].nil?
               Trade.new
             else
               Trade.find(params[:id]).dup

             end
    render :show, layout: 'content'
  end

  def index
    @trades = Trade.all.order('created_at DESC')
    @models = ValueModel.all
    render layout: 'content'
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
