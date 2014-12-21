class TeamsController < ApplicationController
  def index
    @teams = Team.all
    @team_data = []
    @teams.each do |team|
      @user = User.find(team.user)
      league_stats = $client.league.get(team.user.summoner_id).first[1][0]
      id = team.id
      tier = league_stats.tier
      about = team.about
      creator = team.user.summoner_name
      @team_data << { :id => id, :tier => tier, :creator => creator, :about => about, :user => @user }
    end
  end

  def show
    @team = Team.find(params[:id])
    @user = @team.user
    # league_stats = $client.league.get(@team.user.summoner_id).first[1][0]
    @tier = $client.league.get(@team.user.summoner_id).first[1][0].tier
    @comments = @team.comments
    @comment = Comment.new
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user

    if @team.save
      redirect_to @team
    else
      flash[:notice] = "You need to sign in to create a team."
      render 'new'
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    @team.user = current_user

    if @team.update(team_params)
      flash[:success] = "You have successfully updated your team."
      redirect_to team_path(@team)
    else
      flash[:alert] = "Oops! Something went wrong. Please try again."
      render "show"
    end
  end

  def destroy
    @team = Team.find(params[:id])
    if @team.destroy
      flash[:notice] = "Your team has been deleted."
      redirect_to teams_path
    end
  end

  def upvote
    @team = Team.find(params[:id])
    @team.vote_by voter: current_user, vote: 'like'
    redirect_to @team
  end

  def downvote
    @team = Team.find(params[:id])
    @team.vote_by voter: current_user, vote: 'bad'
    redirect_to @team
  end

  private

  def team_params
    params.require(:team).permit(:about)
  end

end
