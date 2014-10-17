class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @user = User.find(params[:user_id])
    @comments = @team.comments
    @comment = Comment.new
    @likes = @team.get_likes.size
    @dislikes = @team.get_dislikes.size
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def team_params
    params.require(:team).permit(:summoner_name, :role, :lolking_link)
  end

end
