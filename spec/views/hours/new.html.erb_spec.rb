require 'rails_helper'

RSpec.describe "hours/new", type: :view do
  before(:each) do
    assign(:hour, Hour.new(
      user_id: "",
      day: 1
    ))
  end

  it "renders new hour form" do
    render

    assert_select "form[action=?][method=?]", hours_path, "post" do

      assert_select "input[name=?]", "hour[user_id]"

      assert_select "input[name=?]", "hour[day]"
    end
  end
end
