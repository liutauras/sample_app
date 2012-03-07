class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # authentificate user and redirect to user show page ..
      sign_in user
      redirect_to user
    else
      # show email/password login error flash and render signin page
      flash.now[:error] = "Invalid email/password combination"
      render "new"
    end 
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
