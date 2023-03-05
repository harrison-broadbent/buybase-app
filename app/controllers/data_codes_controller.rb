class DataCodesController < ApplicationController
  before_action :set_user, :set_dataset, only: :new
  def new
    Stripe.api_key = Rails.application.credentials.stripe[:api_key]

    session = Stripe::Checkout::Session.retrieve(params[:session_id], {stripe_account: @user.connected_account_id})
    customer = Stripe::Customer.retrieve(session.customer, {stripe_account: @user.connected_account_id})

    @data_code = DataCode.create(code: Haikunator.haikunate, customer_email: customer.email, user_id: params[:user_id], dataset_id: params[:dataset_id])
    @data_code.save

  #   TODO: handle edge cases - ie multuple purchases, reloading etc
  end

  private
  # Only allow a list of trusted parameters through.
  def datacode_params
    params.require(:data_code).permit(:session_id, :user_id, :dataset_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_dataset
    @dataset = Dataset.find(params[:dataset_id])
  end
end
