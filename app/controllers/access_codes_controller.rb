# frozen_string_literal: true
class AccessCodesController < ApplicationController
  before_action :set_user, :set_dataset, only: :new

  def index
    access_codes = current_user.access_codes
    # Initialize an empty hash to store the sorted access codes
    sorted_access_codes = {}

    # Loop through all the access codes and sort them into the hash
    access_codes.each do |access_code|
      dataset_name = Dataset.find(access_code.dataset_id).name

      if sorted_access_codes.has_key?(dataset_name)
        sorted_access_codes[dataset_name] << access_code
      else
        sorted_access_codes[dataset_name] = [access_code]
      end
    end

    @access_code_hash = sorted_access_codes
  end
  def new
    Stripe.api_key = Rails.application.credentials.stripe[:api_key]

    session = Stripe::Checkout::Session.retrieve(params[:session_id], {stripe_account: @user.connected_account_id})
    customer = Stripe::Customer.retrieve(session.customer, {stripe_account: @user.connected_account_id})

    # FIXME: handle reloading since currently it genereates a new code
    @access_code = AccessCode.create(code: Haikunator.haikunate, customer_email: customer.email, user_id: params[:user_id], dataset_id: params[:dataset_id])
    @access_code.save

    #   TODO: handle edge cases - ie multuple purchases, reloading etc
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
