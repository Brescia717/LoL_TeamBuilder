class TeamsController < ApplicationController
  def index
    @teams = Team.all
    @team_data = []
    @teams.each do |team|
      @user = User.find(team.user)
      @stat = Stat.find(team.user.stat)
      id = team.id
      tier = @stat.tier
      about = team.about
      creator = team.user.summoner_name
      @team_data << { :id => id, :tier => tier, :creator => creator, :about => about, :user => @user }
    end
    @tier_hash = { 1 => "BRONZE", 2 => "SILVER", 3 => "GOLD", 4 => "PLATINUM", 5 => "DIAMOND", 6 => "MASTER" }
    ### some logic for setting up eligible teams for current_user ###
    if current_user && current_user.stat.nil? == false
      @tier_hash.each do |k,v|
        if v == current_user.stat.tier
          @first  = @tier_hash[k-1]
          @second = @tier_hash[k  ]
          @third  = @tier_hash[k+1]
        end
      end
    end
  end

  def show
    @team = Team.find(params[:id])
    @user = @team.user
    @comments = @team.comments
    @comment = Comment.new

    if current_user.stat.present?
      if current_user.stat.tier != @team.user.stat.tier
        flash[:alert] = "You do not meet the requirements to be on this team!"
      else
        true
      end
    end
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
