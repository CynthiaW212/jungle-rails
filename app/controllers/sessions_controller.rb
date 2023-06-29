class SessionsController < ApplicationController
  def new
  end

  def create
    # If the user exists AND the password entered is correct.
    if @user = User.authenticate_with_credentials(user_params[:email].strip, user_params[:password])
      # Save the user id inside the browser cookie. 
      session[:user_id] = @user.id
      redirect_to '/'
    else
      # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password
    )
  end

  def destroy
    # clear session
    session[:user_id] = nil
    redirect_to '/login', notice:'Logout successfully!'
  end



end
