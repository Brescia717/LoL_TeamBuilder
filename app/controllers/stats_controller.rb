class StatsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @user = current_user
    @stat = Stat.new
  end

  def create
    @user = User.find(params[:user_id])
    @stat = Stat.new(stat_params)
    @stat.user = @user
    @user_summoner_name = @user.summoner_name

    if @stat.save
      StatsUpdateWorker.perform_async(@user_summoner_name, @stat.id)
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
    up_to_date = ( (@stat.updated_at + 1.hour) > Time.now.utc )

    if up_to_date == true
      flash[:alert] = "Stats can only be updated once per hour."
      redirect_to user_path(@stat.user)
    elsif up_to_date == false
      current_tier = check_current_tier
      if @stat.tier != current_tier
        @stat.update_attributes({ tier: current_tier })
        flash[:success] = "Stats update successful!"
      else
        flash[:notice] = "Stats have not changed and are up-to-date"
      end
      redirect_to user_path(@stat.user)
    else
      flash[:alert] = "Please try again - save unsuccessfull."
      redirect_to user_path(@stat.user)
    end
  end

  private

  def stat_params
    params.require(:stat).permit(:summoner_id, :lolking_profile_url, :tier)
  end

  def get_summoner_id(user_summoner_name)
    HTTParty.get("https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/#{user_summoner_name.gsub(/\s+/, "")}?api_key=#{ENV['LOL_API']}").first[1]['id']
  end

  def get_summoner_tier(summoner_id)
    HTTParty.get("https://na.api.pvp.net/api/lol/na/v2.5/league/by-summoner/#{summoner_id}/entry?api_key=#{ENV['LOL_API']}").first[1][0]['tier']
  end

  def get_lolking_profile_url(summoner_id)
    "http://www.lolking.net/summoner/na/#{summoner_id}"
  end

  def check_current_tier
    cache = ActiveSupport::Cache::MemoryStore.new
    request_tier = get_summoner_tier(@stat.summoner_id)
    cache.write("current_tier", request_tier)
    current_tier = cache.fetch("current_tier")
    return current_tier
  end
end
