class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find(params[:user_id]) # 
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: @user.id)

    if @collaborator.save
      flash[:notice] = "Your wiki was succesfully updated with a collaborator"
      redirect_to @wiki
    else
      flash[:error] = "There was a problem in uploading a wiki with a collaborator. Please try again"
      render"edit"
    end    
  end

  def destroy

    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "Collaborator was removed successfully"
      redirect_to @wiki
    else
      flash[:error] = "There was an error removing a collaborator.Please try again"  
      render "show"
    end
  end
end  
