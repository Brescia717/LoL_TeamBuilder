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
    @stat.user = current_user
    @stat.user_id = current_user.id
    @stat.summoner_id = HTTParty.get("https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/#{@user.summoner_name.gsub(/\s+/, "")}?api_key=#{ENV['LOL_API']}").first[1]['id']
    @stat.lolking_profile_url = "http://www.lolking.net/summoner/na/#{@stat.summoner_id}"
    @stat.tier = HTTParty.get("https://na.api.pvp.net/api/lol/na/v2.5/league/by-summoner/#{@stat.summoner_id}/entry?api_key=#{ENV['LOL_API']}").first[1][0]['tier']
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

    if @stat.update(stat_params)
      @stat.update_attributes({:tier => HTTParty.get("https://na.api.pvp.net/api/lol/na/v2.5/league/by-summoner/#{@stat.summoner_id}/entry?api_key=#{ENV['LOL_API']}").first[1][0]['tier'].to_s})
      flash[:success] = "You have successfully updated your stats."
      redirect_to user_path(@stat.user)
    else
      flash[:notice] = "Please try again - save unsuccessfull."
      redirect_to @user
    end
  end

  def show
  end

  private

  def stat_params
    params.require(:stat).permit(:summoner_id, :lolking_profile_url, :tier)
  end
end
