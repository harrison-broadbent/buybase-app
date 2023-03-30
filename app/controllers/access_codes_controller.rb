# frozen_string_literal: true
class AccessCodesController < ApplicationController
  before_action :set_user, :set_dataset, only: :new
  def new
    Stripe.api_key = Rails.application.credentials.stripe[:api_key]

    session = Stripe::Checkout::Session.retrieve(params[:session_id], {stripe_account: @user.connected_account_id})
    customer = Stripe::Customer.retrieve(session.customer, {stripe_account: @user.connected_account_id})
    puts session
    # FIXME: handle reloading since currently it genereates a new code
    @access_code = AccessCode.create(code: Haikunator.haikunate, customer_email: customer.email, user_id: params[:user_id], dataset_id: params[:dataset_id])
    @access_code.save

    #   TODO: handle edge cases - ie multuple purchases, reloading etc

    # track purchase for analytics
    ahoy.track 'Purchased Dataset', id: params[:dataset_id], user_id: params[:user_id], customer_email: customer.email, amount: session.amount_total
  end

  private
  # Only allow a list of trusted parameters through.
  def access_code_params
    params.require(:access_code).permit(:session_id, :user_id, :dataset_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_dataset
    @dataset = Dataset.find(params[:dataset_id])
  end
end
