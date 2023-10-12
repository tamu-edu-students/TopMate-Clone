require 'rails_helper'

RSpec.describe "hours/index", type: :view do
  before(:each) do
    assign(:hours, [
      Hour.create!(
        user_id: "",
        day: 2
      ),
      Hour.create!(
        user_id: "",
        day: 2
      )
    ])
  end

  it "renders a list of hours" do
    render
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
