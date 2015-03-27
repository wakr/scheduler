require "rails_helper"

describe "Routes for Users", :type => :routing do
  it "routes /users to the users controller" do
    expect(get("/users")).
      to route_to("users#index")
  end
end
