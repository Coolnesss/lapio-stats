class UsersController < ApplicationController

  before_action :authorize_self, except: [:new, :create]

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

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:student_id, :password, :password_confirmation)
  end
end
