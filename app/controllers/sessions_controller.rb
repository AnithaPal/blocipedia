class SessionsController < ApplicationController
  def new
  end

  def create
   user = User.authenticate(params[:email], params[:password])
  # user = User.authenticate(session_params)
  if user
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in successfully!"
  else
    flash.now.alert = "Invalid email or password"
    render "new"
  end
end

def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => "Signed out successfully"
end  

  # private

  # def session_params
  #   params.require(:session).permit(:email, :password)
  # end  
end
