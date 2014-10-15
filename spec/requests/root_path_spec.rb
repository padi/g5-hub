require "rails_helper"

describe "Integration '/'", auth_request: true do
  before do
    visit root_path
  end

  it "should display 'G5 Hub'" do
    expect(page).to have_content("G5 Hub")
  end
end
