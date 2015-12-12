class TeamsController < ApplicationController
  before_action :get_team,
                  only: [ :show, :edit, :update, :destroy, :upvote, :downvote ]

  def index
    @teams = Team.all
    @team_data = get_team_data(@teams)
    @eligible_teams = get_eligible_teams
  end

  def show
    @user = @team.user
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
  end

  def update
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
    if @team.destroy
      flash[:notice] = "Your team has been deleted."
      redirect_to teams_path
    end
  end

  def upvote
    @team.vote_by voter: current_user, vote: 'like'
    redirect_to @team
  end

  def downvote
    @team.vote_by voter: current_user, vote: 'bad'
    redirect_to @team
  end

  private

  def team_params
    params.require(:team).permit(:about)
  end

  def get_team
    @team = Team.find(params[:id])
  end

  def get_team_data(teams)
    team_data = []
    teams.each do |team|
      team_user = team.user
      id = team.id
      user = User.find(team_user)
      tier = Stat.find(team_user.stat).tier
      creator = team_user.summoner_name
      about = team.about
      team_data << { :id => id, :user => user, :tier => tier,
                     :creator => creator, :about => about }
    end
    team_data
  end

  # Sets up eligible teams if current_user
  def get_eligible_teams
    eligible_teams = []
    if current_user && current_user.stat.nil? == false
      tier_hash = { 1 => "BRONZE",   2 => "SILVER",  3 => "GOLD",
                    4 => "PLATINUM", 5 => "DIAMOND", 6 => "MASTER" }
      tier_hash.each do |k,v|
        if v == current_user.stat.tier
          eligible_teams << [ tier_hash[k-1], tier_hash[k], tier_hash[k+1] ]
        end
      end
      eligible_teams.flatten! unless eligible_teams.empty?
    end
    eligible_teams
  end

end
