class Admin::UserViewsController < ApplicationController
  
  before_action :authenticate_admin

  def create
    session[:view_as_user] = true
    redirect_to referer
  end

  def destroy
    session.delete(:view_as_user)
    redirect_to referer
  end
end
