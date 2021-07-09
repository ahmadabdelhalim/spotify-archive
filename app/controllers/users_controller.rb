class UsersController < ApplicationController  
  def destroy
    current_user.destroy
    redirect_to root_path, notice: 'Your account was deleted successfully!'
  end
end