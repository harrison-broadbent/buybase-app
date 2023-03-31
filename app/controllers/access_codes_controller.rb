# frozen_string_literal: true
class AccessCodesController < ApplicationController
  before_action :set_user, :set_dataset, only: :checkout_success

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
    @access_code = current_user.access_codes.build
  end

  def create
    @access_code = current_user.access_codes.create(access_code_params)
    @access_code.code = Haikunator.haikunate

    respond_to do |format|
      if @access_code.save
        format.html { redirect_to access_codes_path, notice: 'Access code was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datasets/1 or /datasets/1.json
  def update
    respond_to do |format|
      if @access_code.update(dataset_params)
        format.html { redirect_to access_codes_path, notice: 'Access code was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end
  def checkout_success
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
    params.require(:access_code).permit(:session_id, :user_id, :dataset_id, :customer_email)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_dataset
    @dataset = Dataset.find(params[:dataset_id])
  end
end
