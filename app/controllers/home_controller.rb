class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if user_signed_in?
      if current_user.roles.in_tenant.empty?
        redirect_to new_tenant_path
      else
        redirect_to tenants_path
      end
    end
  end

end
