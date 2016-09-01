class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to login_path, notice:'you should be signed in' unless current_user
  end

  def authorize_self
    case params[:controller]
    when "submissions"
      redirect_to login_path, notice: "This isn't yours to modify!" unless Submission.find(params[:id]).user == current_user
    when "users"
      redirect_to login_path, notice: "This isn't yours to modify!" unless current_user.id.to_s == params[:id] or current_user.admin?
    end
  end

  def authorize_admin
    redirect_to login_path, notice: 'you should be an admin to view this' unless current_user and current_user.admin?
  end
end
