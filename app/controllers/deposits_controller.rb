class DepositsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_agent!

  def index
    @deposits = current_user.deposits.order(created_at: :desc)
  end

  def new
    @deposit = Deposit.new
  end

  def create
    @deposit = current_user.deposits.build(deposit_params)

    if @deposit.save
      redirect_to deposits_path, notice: "Dépôt enregistré avec succès"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def deposit_params
    params.require(:deposit).permit(:client_phone, :amount)
  end
end