require 'roo'

class DatasetsController < ApplicationController
  before_action :set_dataset, only: %i[ show edit update destroy ]

  # GET /datasets or /datasets.json
  def index
    @datasets = Dataset.all
  end

  # GET /datasets/1 or /datasets/1.json
  def show
    @dataset.file.open do |file|
      @data = SmarterCSV.process(file)
      gon.table_data = @data
    end
  end

  # GET /datasets/new
  def new
    @dataset = Dataset.new
  end

  # GET /datasets/1/edit
  def edit
  end

  def create_checkout_session
    # Stripe::Checkout::Session.create(
    #   {
    #     mode: 'payment',
    #     line_items: [{price: '{{PRICE_ID}}', quantity: 1}],
    #     payment_intent_data: {application_fee_amount: 123},
    #     success_url: 'https://example.com/success',
    #     cancel_url: 'https://example.com/cancel',
    #   },
    #   {stripe_account: '{{CONNECTED_ACCOUNT_ID}}'},
    #   )
  end

  # POST /datasets or /datasets.json
  def create
    @dataset = current_user.datasets.create(dataset_params)

    respond_to do |format|
      if @dataset.save
        format.html { redirect_to dataset_url(@dataset), notice: "Dataset was successfully created." }
        format.json { render :show, status: :created, location: @dataset }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dataset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datasets/1 or /datasets/1.json
  def update
    respond_to do |format|
      if @dataset.update(dataset_params)
        format.html { redirect_to dataset_url(@dataset), notice: "Dataset was successfully updated." }
        format.json { render :show, status: :ok, location: @dataset }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dataset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datasets/1 or /datasets/1.json
  def destroy
    @dataset.destroy

    respond_to do |format|
      format.html { redirect_to datasets_url, notice: "Dataset was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dataset
      @dataset = Dataset.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dataset_params
      params.require(:dataset).permit(:name, :file)
    end
end