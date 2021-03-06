class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki).paginate(page: params[:page], per_page: 10)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved"
      redirect_to @wiki
    else
      flash[:notice] = "There was an error saving a wiki. Please try again"
      render "new"
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated successfully"
      redirect_to @wiki
    else
      flash[:notice] = "There was an error updating a wiki. Please try again" 
      render "edit"
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "Wiki was deleted successfully"
      redirect_to wikis_path
    else
      flash[:notice] = "There was an error deleting a wiki. Please try again"  
      render "show"
    end
  end


  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
