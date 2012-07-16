require 'spec_helper'

describe "adoptions/new" do
  before(:each) do
    assign(:adoption, stub_model(Adoption,
      :user_id => "",
      :title => "",
      :descr => "",
      :approved => false
    ).as_new_record)
  end

  it "renders new adoption form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => adoptions_path, :method => "post" do
      assert_select "input#adoption_user_id", :name => "adoption[user_id]"
      assert_select "input#adoption_title", :name => "adoption[title]"
      assert_select "input#adoption_descr", :name => "adoption[descr]"
      assert_select "input#adoption_approved", :name => "adoption[approved]"
    end
  end
end
