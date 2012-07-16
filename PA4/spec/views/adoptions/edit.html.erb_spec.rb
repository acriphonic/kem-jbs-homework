require 'spec_helper'

describe "adoptions/edit" do
  before(:each) do
    @adoption = assign(:adoption, stub_model(Adoption,
      :user_id => "",
      :title => "",
      :descr => "",
      :approved => false
    ))
  end

  it "renders the edit adoption form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => adoptions_path(@adoption), :method => "post" do
      assert_select "input#adoption_user_id", :name => "adoption[user_id]"
      assert_select "input#adoption_title", :name => "adoption[title]"
      assert_select "input#adoption_descr", :name => "adoption[descr]"
      assert_select "input#adoption_approved", :name => "adoption[approved]"
    end
  end
end
