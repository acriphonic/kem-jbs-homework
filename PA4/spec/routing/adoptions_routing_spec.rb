require "spec_helper"

describe AdoptionsController do
  describe "routing" do

    it "routes to #index" do
      get("/adoptions").should route_to("adoptions#index")
    end

    it "routes to #new" do
      get("/adoptions/new").should route_to("adoptions#new")
    end

    it "routes to #show" do
      get("/adoptions/1").should route_to("adoptions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/adoptions/1/edit").should route_to("adoptions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/adoptions").should route_to("adoptions#create")
    end

    it "routes to #update" do
      put("/adoptions/1").should route_to("adoptions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/adoptions/1").should route_to("adoptions#destroy", :id => "1")
    end

  end
end
