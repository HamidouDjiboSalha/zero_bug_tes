class SupervisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_supervisor_or_admin!

  # Liste des dépôts/retraits en attente
  def index
    @pending_deposits = Deposit.where(status: "pending").order(created_at: :desc)
    @pending_withdrawals = Withdrawal.where(status: "pending").order(created_at: :desc)
  end

  # Accepter un dépôt/retrait
  def approve
    resource = find_resource
    resource.update(status: "accepted")
    redirect_back(fallback_location: supervisions_path, notice: "✅ Transaction validée")
  end

  # Rejeter un dépôt/retrait
  def reject
    resource = find_resource
    resource.update(status: "rejected")
    redirect_back(fallback_location: supervisions_path, alert: "❌ Transaction rejetée")
  end

  private

  def require_supervisor_or_admin!
    unless current_user.superviseur? || current_user.admin?
      redirect_to dashboard_path, alert: "Accès interdit"
    end
  end

  def find_resource
    if params[:type] == "deposit"
      Deposit.find(params[:id])
    elsif params[:type] == "withdrawal"
      Withdrawal.find(params[:id])
    else
      raise "Type invalide"
    end
  end
end