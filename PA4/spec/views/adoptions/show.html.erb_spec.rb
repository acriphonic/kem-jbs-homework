require 'spec_helper'

describe "adoptions/show" do
  before(:each) do
    @adoption = assign(:adoption, stub_model(Adoption,
      :user_id => "",
      :title => "",
      :descr => "",
      :approved => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/false/)
  end
end
