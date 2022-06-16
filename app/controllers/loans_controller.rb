class LoansController < ApiBaseController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  before_action :fetch_loan_detail, only: [:show]

  def index
    response_data = []
    Loan.includes(:payments).each do |loan|
      response_data << { loan_id: loan.id, outstanding_balance: loan.funded_amount - loan.payments.sum(:amount) }
    end
    render json: response_data
  end

  def show
    outstanding_balance = @loan.funded_amount - @loan.payments.sum(:amount)
    render json: { loan_id: @loan.id, start_date: @loan.created_at, starting_loan_amount: @loan.funded_amount, outstanding_balance: outstanding_balance }
  end
end
