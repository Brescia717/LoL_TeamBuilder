class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:upvote, :downvote]

  def call_client
    require 'lol'
    @client = Lol::Client.new(ENV['LOL_API'], {region: 'na'})
  end

  def index
  end

  def show
    call_client # creates @client
    @user = User.find(params[:id])
    @bios = @user.bios
    @bio = Bio.new
    summoner_id = @client.summoner.by_name("#{@user.summoner_name}").first.id
    @lolking_profile_url = "http://www.lolking.net/summoner/na/#{summoner_id}"
    league_stats = @client.league.get(summoner_id.to_i).first[1][0]
    @tier = league_stats.tier
    @division = league_stats.entries.first.division
    @likes = @user.get_likes.size
    @dislikes = @user.get_dislikes.size
    @percentage_likes=
    if @likes > 0
      sprintf('%.0f', ((@likes.to_f / (@likes.to_f + @dislikes.to_f)) * 100)).to_s + '%'
    elsif @likes == 0 && @dislikes == 0
      "No registered votes"
    elsif @likes == 0 && @dislikes > 0
      "Uh-oh, better change your behavior!"
    else
      "100%"
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      # flash[:success] = "You have successfully updated your profile."
      redirect_to user_path(@user)
    else
      # flash[:alert] = "You need to submit a photo."
      render 'show'
    end
  end

  def upvote
    @user = User.find(params[:id])
    @user.vote_by voter: current_user, vote: 'like'
    redirect_to @user
  end

  def downvote
    @user = User.find(params[:id])
    @user.vote_by voter: current_user, vote: 'bad'
    redirect_to @user
  end

  private
  def user_params
    return { email: nil } unless params[:user]
    params.require(:user).permit(:email)
  end
end
