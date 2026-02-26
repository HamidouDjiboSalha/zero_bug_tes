class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:check, :result]

  def check
  end

  def result
    @payment = Payment.find_by(reference: params[:reference])

    if @payment.nil?
      flash.now[:alert] = "Aucun paiement trouvé pour cette référence"
      render :check
    end
  end
end
