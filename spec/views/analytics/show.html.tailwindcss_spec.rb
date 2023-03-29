require 'rails_helper'

RSpec.describe "analytics/show", type: :view do
  before(:each) do
    @analytic = assign(:analytic, Analytic.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
