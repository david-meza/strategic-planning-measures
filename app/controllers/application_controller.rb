class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :store_referer

  def authenticate_admin
    unless current_user.try(:admin?)
      flash[:notice] = "Please sign in as an admin to access this section."
      redirect_to referer
    end
  end

  def store_referer
    session[:referer] = request.referer ? URI(request.referer).path : root_path
  end

  def referer
    session[:referer]
  end

end
