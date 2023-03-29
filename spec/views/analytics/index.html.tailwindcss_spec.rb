require 'rails_helper'

RSpec.describe "analytics/index", type: :view do
  before(:each) do
    assign(:analytics, [
      Analytic.create!(),
      Analytic.create!()
    ])
  end

  it "renders a list of analytics" do
    render
  end
end
