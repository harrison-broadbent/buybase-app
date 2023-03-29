require 'rails_helper'

RSpec.describe "analytics/new", type: :view do
  before(:each) do
    assign(:analytic, Analytic.new())
  end

  it "renders new analytic form" do
    render

    assert_select "form[action=?][method=?]", analytics_path, "post" do
    end
  end
end
