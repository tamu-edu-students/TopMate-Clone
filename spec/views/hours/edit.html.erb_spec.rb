require 'rails_helper'

RSpec.describe "hours/edit", type: :view do
  before(:each) do
    @hour = assign(:hour, Hour.create!(
      user_id: "",
      day: 1
    ))
  end

  it "renders the edit hour form" do
    render

    assert_select "form[action=?][method=?]", hour_path(@hour), "post" do

      assert_select "input[name=?]", "hour[user_id]"

      assert_select "input[name=?]", "hour[day]"
    end
  end
end
