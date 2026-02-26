class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin? || current_user.superviseur?
      # Tous les dépôts et retraits pour la supervision
      @deposits = Deposit.order(created_at: :desc)
      @withdrawals = Withdrawal.order(created_at: :desc)
    else
      # Seulement les transactions de l’agent
      @deposits = current_user.deposits.order(created_at: :desc)
      @withdrawals = current_user.withdrawals.order(created_at: :desc)
    end
  end
end