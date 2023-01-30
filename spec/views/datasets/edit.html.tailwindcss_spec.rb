require 'rails_helper'

RSpec.describe "datasets/edit", type: :view do
  before(:each) do
    @dataset = assign(:dataset, Dataset.create!(
      name: "MyString",
      user: nil
    ))
  end

  it "renders the edit dataset form" do
    render

    assert_select "form[action=?][method=?]", dataset_path(@dataset), "post" do

      assert_select "input[name=?]", "dataset[name]"

      assert_select "input[name=?]", "dataset[user_id]"
    end
  end
end
