class TeamsController < ApplicationController
  before_action :get_team, only: [ :show, :edit, :update, :destroy, :upvote,
                                   :downvote ]

  def index
    @teams = Team.all
    @user = User.find(team.user)
    @stat = Stat.find(team.user.stat)
    @team_data = get_team_data(@teams, @user, @stat)
    get_eligible_teams  #  Creates @first, @second, and @third
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

  def get_team_data(teams, user, stat)
    team_data = []
    teams.each do |team|
      id = team.id
      tier = stat.tier
      about = team.about
      creator = team.user.summoner_name
      team_data << { :id => id, :tier => tier, :creator => creator, :about => about, :user => user }
    end
    team_data
  end

  # Sets up eligible teams for current user
  def get_eligible_teams
    tier_hash = { 1 => "BRONZE", 2 => "SILVER", 3 => "GOLD", 4 => "PLATINUM", 5 => "DIAMOND", 6 => "MASTER" }
    if current_user && current_user.stat.nil? == false
      tier_hash.each do |k,v|
        if v == current_user.stat.tier
          @first  = tier_hash[k-1]
          @second = tier_hash[k  ]
          @third  = tier_hash[k+1]
        end
      end
    end
  end
end
