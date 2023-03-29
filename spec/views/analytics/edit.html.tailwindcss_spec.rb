require 'rails_helper'

RSpec.describe "analytics/edit", type: :view do
  before(:each) do
    @analytic = assign(:analytic, Analytic.create!())
  end

  it "renders the edit analytic form" do
    render

    assert_select "form[action=?][method=?]", analytic_path(@analytic), "post" do
    end
  end
end
