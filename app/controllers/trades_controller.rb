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
    safe_params = trade_params
    team_a = Team.find_by(shortname: safe_params[:team_a_shortname])
    team_b = Team.find_by(shortname: safe_params[:team_b_shortname])
    safe_params.delete(:team_a_shortname)
    safe_params.delete(:team_b_shortname)
    @trade = Trade.new(safe_params.merge(team_a:, team_b:, team_a_picks: (safe_params[:team_a_picks] || []).map(&:to_i),
                                         team_b_picks: (safe_params[:team_b_picks] || []).map(&:to_i)))
    if @trade.save
      redirect_to @trade, notice: 'Trade Saved'
    else
      @models = ValueModel.all
      @teams = Team.all
      @all_picks = DraftPick.all
      @picks_by_team = @all_picks.group_by(&:team)
      render :show, layout: 'content', status: :unprocessable_entity
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
    params.require(:trade).permit(:team_a_shortname, :team_b_shortname, team_a_picks: [], team_b_picks: [])
  end
end
