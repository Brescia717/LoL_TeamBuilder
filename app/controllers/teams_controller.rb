class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    # @user = User.find(params[:user_id])
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
      redirect_to @team ## This will be redirect_to @team
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
      redirect_to root_path
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
    params.require(:team).permit(:about, :rank, :primary_role,
                                 :secondary_role)
  end

end
