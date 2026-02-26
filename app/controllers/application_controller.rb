class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!

  protected

  # Pour le PIN
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:pin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:pin])
  end

  # Admin
  def require_admin!
    redirect_to root_path, alert: "Accès refusé" unless current_user.admin?
  end

  # Superviseur
  def require_superviseur!
    redirect_to root_path, alert: "Accès refusé" unless current_user.superviseur? || current_user.admin?
  end

  # Agent
  def require_agent!
    unless current_user.agent? || current_user.superviseur? || current_user.admin?
      redirect_to dashboard_path, alert: "Accès interdit"
    end
  end
end
