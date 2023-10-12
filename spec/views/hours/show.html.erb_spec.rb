require 'rails_helper'

RSpec.describe "hours/show", type: :view do
  before(:each) do
    @hour = assign(:hour, Hour.create!(
      user_id: "",
      day: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
