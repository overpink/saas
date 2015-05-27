class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def current_tenant
    Tenant.find_by(slug: request.subdomain)
  end
  helper_method :current_tenant
end
