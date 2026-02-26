class DashboardController < ApplicationController
    before_action :authenticate_user!

  def index
    # Dépôts validés
    @validated_deposits = Deposit.where(status: "validated").order(created_at: :desc)

    # Retraits validés
    @validated_withdrawals = Withdrawal.where(status: "validated").order(created_at: :desc)

    # Totaux
    @total_deposits = @validated_deposits.sum(:amount)
    @total_withdrawals = @validated_withdrawals.sum(:amount)
  end


    @total_deposits = Deposit.where(status: "accepted").sum(:amount)
    @total_withdrawals = Withdrawal.where(status: "accepted").sum(:amount)
    @transactions_today = Deposit.where(status: "accepted", created_at: Date.today.all_day).count +
                        Withdrawal.where(status: "accepted", created_at: Date.today.all_day).count
end
