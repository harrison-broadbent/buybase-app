require 'rails_helper'

RSpec.describe "datasets/new", type: :view do
  before(:each) do
    assign(:dataset, Dataset.new(
      name: "MyString",
      user: nil
    ))
  end

  it "renders new dataset form" do
    render

    assert_select "form[action=?][method=?]", datasets_path, "post" do

      assert_select "input[name=?]", "dataset[name]"

      assert_select "input[name=?]", "dataset[user_id]"
    end
  end
end
