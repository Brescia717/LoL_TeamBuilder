class BiosController < ApplicationController
  before_action :get_bio, only: [ :edit, :update, :destroy ]

  def new
    @bio = Bio.new
  end

  def create
    @user = User.find(params[:user_id])
    @bio  = Bio.new(bio_params)
    @bio.user    = current_user
    @bio.user_id = params[:user_id]
    if @bio.save
      flash[:success] = "Bio update successful!"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Bio cannot be blank."
      redirect_to user_path(@user)
    end
  end

  def edit
  end

  def update
    if @bio.update(bio_params)
      flash[:notice] = "You have successfully updated your bio."
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Please correct the changes."
      render 'edit'
    end
  end

  def destroy
    @bio.destroy
    flash[:success] = "You have successfully removed your bio."
    redirect_to user_path(current_user)
  end

  private
  def bio_params
    params.require(:bio).permit(:body)
  end

  def get_bio
    @bio = Bio.find(params[:id])
  end
end
