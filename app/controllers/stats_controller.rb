class StatsController < ApplicationController

  def index
  end

  def new
    @user = current_user
    @stat = Stat.new
  end

  def create
    @user = User.find(params[:user_id])
    @stat = Stat.new(stat_params)
    @stats = Stat.create(:user_id => current_user.id, :summoner_id => summoner_data.first[1]['id'], :lolking_profile_url => "http://www.lolking.net/summoner/na/#{}")
    # @stat.user = current_user
    # @stat.user_id = current_user.id
    if @stat.summoner_id != nil && @stat.lolking_profile_url != nil && @stat.tier != nil
      @stat.save
      flash[:success] = "Stats successfully created!"
      redirect_to @user
    else
      flash[:notice] = "It didn't save, please try again."
      redirect_to @user
    end
  end

  def edit
    @stat = Stat.find(params[:id])
  end

  def update
    @stat = Stat.find(params[:id])
    cache = ActiveSupport::Cache::MemoryStore.new
    request_tier = HTTParty.get("https://na.api.pvp.net/api/lol/na/v2.5/league/by-summoner/#{@stat.summoner_id}/entry?api_key=#{ENV['LOL_API']}").first[1][0]['tier']
    cache.write("current_tier", request_tier)
    current_tier = cache.fetch("current_tier")

    if current_tier.present? && current_tier != @stat.tier
      @stat.update(stat_params)
      @stat.update_attributes({:tier => current_tier})
      flash[:success] = "You have successfully updated your stats."
      redirect_to user_path(@stat.user)
    elsif current_tier.present? && current_tier == @stat.tier
      @stat.update(stat_params)
      flash[:notice] = "Everything is up-to-date."
      redirect_to user_path(current_user)
    else
      # @stat.update(stat_params)
      flash[:alert] = "Please try again - save unsuccessfull."
      redirect_to user_path(current_user)
    end
  end

  def show
  end

  private

  def stat_params
    params.require(:stat).permit(:summoner_id, :lolking_profile_url, :tier)
  end

end
