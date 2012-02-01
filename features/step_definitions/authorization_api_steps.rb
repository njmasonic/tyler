Given /^the api key "([^"]*)" is enabled$/ do |key|
  # ApiKey needs to be created and then updated to bypass automatic key generation
  api_key = ApiKey.create!
  api_key.key = key
  api_key.save!
end

Given /^the following attributes are required for registration:$/ do |table|
  APP_CONFIG["registration_properties"] = []
  table.raw.each do |property|
    APP_CONFIG["registration_properties"] << property[0]
  end
end

Given /^there are no configured registration properties$/ do
  APP_CONFIG["registration_properties"] = []
end

Given /^the authorization code "([^"]*)" is valid and unused$/ do |authorization_code|
  Authorization.create! code: authorization_code
end

When /^I use the api key "([^"]*)" to create the authorization:$/ do |key, table|
  parameters = { key: key, authorization: table.rows_hash }
  lambda {
    post "/api/authorizations", parameters
  }.should change(Authorization, :count).by(1)
end

Then /^I can sign up "([^"]*)" using:$/ do |email, table|
  step %{I fill in the sign up form for "#{email}" using:}, table
  page.should_not have_content('Registration information is not valid')
end

Then /^I can't sign up "([^"]*)" using:$/ do |email, table|
  step %{I fill in the sign up form for "#{email}" using:}, table
  page.should have_content('Registration information is not valid')
end

Then /^I fill in the sign up form for "([^"]*)" using:$/ do |email, table|
  visit sign_up_path
  fill_in "Email", :with => email
  fill_in "Password", :with => "mypassword"
  table.rows_hash.each do |key, value|
    fill_in key.humanize, :with => value
  end
  click_button "Sign up"
end
