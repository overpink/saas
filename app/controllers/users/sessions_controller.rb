class Users::SessionsController < Devise::SessionsController

  def create
    # render json: current_tenant; return false;

    if current_tenant

      if user_exists = User.find_by(email: params[:user][:email])
        if !user_exists.roles.in_tenant.where(resource_id: current_tenant.id).empty?
          super
        else
          redirect_to new_user_session_path, notice: "Oh noes! you are not part of this organisation, GTFOH!" and return
        end
      else
        sign_out if Devise.sign_out_all_scopes
        redirect_to new_user_session_path, notice: "Oh noes! you are not part of this organisation, GTFOH!" and return
      end
    else
      super
    end
  end

  def after_sign_in_path_for(resource)
    if current_tenant
      current_tenant.url(dashboard_index_path)
    else
      tenants_url(subdomain: false)
    end
    # after_sign_in_path_for(resource)
  end


end