require 'roo'

class DatasetsController < ApplicationController
  before_action :set_dataset, only: %i[ show edit update destroy ]

  # GET /datasets or /datasets.json
  def index
    @datasets = current_user.datasets.all
  end

  # GET /datasets/1 or /datasets/1.json
  def show
    # show if the customer code is valid, or if the current user owns the dataset
    @customer_code_valid = @dataset.access_code_is_valid?(params[:customer_access_code]) || (current_user.id == @dataset.user.id unless current_user == nil)
    if @customer_code_valid
      if @dataset.spreadsheet?
        @dataset.file.open do |file|
          @data = SmarterCSV.process(file)
          gon.table_data = @data
        end
      elsif @dataset.airtable?
        airtable_code = @dataset.database_url.split('?')[0].split('/').last
        @airtable_url = "https://airtable.com/embed/#{airtable_code}?backgroundColor=purple"
      elsif @dataset.notion?
        notion_code = @dataset.database_url.split('?')[0].split('/').last
        @notion_url = "https://react-notion-x-demo.transitivebullsh.it/#{notion_code}"
      end
    else
      @checkout_url = @dataset.stripe_create_checkout_session
    end
  end

  # GET /datasets/new
  def new
    @dataset = Dataset.new
  end

  # GET /datasets/1/edit
  def edit
    gon.dataset_type = @dataset.dataset_type
  end

  # POST /datasets or /datasets.json
  def create
    @dataset = current_user.datasets.create(dataset_params)
    puts dataset_params


    respond_to do |format|
      if @dataset.save
        format.html { redirect_to dataset_url(@dataset), notice: 'Dataset was successfully created.' }
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
        format.html { redirect_to dataset_url(@dataset), notice: 'Dataset was successfully updated.' }
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
      format.html { redirect_to datasets_url, notice: 'Dataset was successfully destroyed.' }
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
    params.require(:dataset).permit(:name, :file, :price, :customer_access_code, :database_url, :dataset_type)
  end
end
