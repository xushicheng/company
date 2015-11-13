class Admin::BaseController < ApplicationController
  layout 'layouts/admin'
  before_action :login_admin_user

end
