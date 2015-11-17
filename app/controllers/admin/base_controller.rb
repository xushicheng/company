class Admin::BaseController < ApplicationController
  layout 'layouts/admin'
  before_action :logged_admin


  private
  def logged_admin
    unless logged_in? && current_user.admin?
      redirect_to root_path
    end
  end

  helper_method :logged_admin
end
