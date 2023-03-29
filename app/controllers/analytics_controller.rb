class AnalyticsController < ApplicationController

  # GET /analytics or /analytics.json
  def index
    @users_dataset_views = current_user.total_dataset_views_last_n_days(7)
  end
end