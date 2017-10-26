require 'rails_helper'
feature "creating creating new reservation" do
  background do
    sign_in_as(user)
    Url.create(:long_url => 'http://test.com')
  end

  scenario "Making new url" do
    visit '/urls/'
    click_link "Shorten a Url!"
  end
end