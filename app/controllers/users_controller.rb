class UsersController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    @user = current_user
      if @user.update_attributes(user_params)
        flash[:success]="User updated successfully"
        redirect_to root_path
      else
        flash[:danger]="Error updating user"
      render 'edit'
      end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
