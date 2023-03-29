class AnalyticsController < ApplicationController

  # GET /analytics or /analytics.json
  def index
    @views_last_7_days = current_user.total_dataset_views_last_n_days(7)
  end
end