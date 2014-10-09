require "rails_helper"

describe TagsController, auth_controller: true do
  render_views

  describe "#show" do
    it "renders show template" do
      get :show, id: "tagname"
      expect(response).to render_template(:show)
    end
  end
end
