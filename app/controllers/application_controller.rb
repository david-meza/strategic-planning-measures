class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin
    unless current_user.admin?
      flash[:notice] = "Please sign in as an admin to access this section."
      redirect_to referer
    end
  end

  def referer
    URI(request.referer).path
  end

end
