require 'spec_helper'

describe "adoptions/index" do
  before(:each) do
    assign(:adoptions, [
      stub_model(Adoption,
        :user_id => "",
        :title => "",
        :descr => "",
        :approved => false
      ),
      stub_model(Adoption,
        :user_id => "",
        :title => "",
        :descr => "",
        :approved => false
      )
    ])
  end

  it "renders a list of adoptions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
