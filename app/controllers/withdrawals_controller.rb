class WithdrawalsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_agent!

  def index
    @withdrawals = current_user.withdrawals.order(created_at: :desc)
  end

  def new
    @withdrawal = Withdrawal.new
  end

  def create
    @withdrawal = current_user.withdrawals.build(withdrawal_params)

    if @withdrawal.save
      redirect_to withdrawals_path, notice: "✅ Retrait enregistré avec succès"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def withdrawal_params
    params.require(:withdrawal).permit(:client_phone, :amount)
  end
end