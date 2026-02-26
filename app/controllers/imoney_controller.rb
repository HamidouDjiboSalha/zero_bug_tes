class ImoneyController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_service!

  ALLOWED_SERVICES = %w[depot retrait canal kyc]

  def show
    @service = params[:service]
  end

  private

  def authorize_service!
    service = params[:service]

    case service
    when "depot", "retrait"
      return if current_user.agent? || current_user.superviseur? || current_user.admin?
    when "kyc"
      return if current_user.superviseur? || current_user.admin?
    else
      return if current_user.admin?
    end

    redirect_to dashboard_path, alert: "Accès non autorisé"
  end
end