class BiosController < ApplicationController

  def new
    @bio = Bio.new
  end

  def create
    @user = User.find(params[:user_id])
    @bio = Bio.new(bio_params)
    @bio.user = current_user
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
    @bio = Bio.find(params[:id])
  end

  def update
    @bio = Bio.find(params[:id])
    if @bio.update(bio_params)
      flash[:notice] = "You have successfully updated your bio."
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Please correct the changes."
      render 'edit'
    end
  end

  def destroy
    @bio = Bio.find(params[:id])
    @bio.destroy
    flash[:success] = "You have successfully removed your bio."
    redirect_to user_path(current_user)
  end

  private
  def bio_params
    params.require(:bio).permit(:body)
  end
end
