Given /^the api key "([^"]*)" is enabled$/ do |key|
  ApiKey.create! key: key
end

Given /^the following attributes are required for registration:$/ do |table|
  APP_CONFIG["registration_properties"] = []
  table.raw.each do |property|
    APP_CONFIG["registration_properties"] << property[0]
  end
end

Given /^authorization is not required for registration$/ do
  APP_CONFIG["registration_properties"] = []
end

When /^I use the api key "([^"]*)" to create the authorization:$/ do |key, table|
  parameters = { key: key, authorization: table.rows_hash }
  post "/api/authorizations", parameters.to_json
end

Then /^I can sign up "([^"]*)" using:$/ do |email, table|
  visit sign_up_path
  fill_in "Email", :with => email
  fill_in "Password", :with => "mypassword"
  table.rows_hash.each do |key, value|
    fill_in key.humanize, :with => value
  end
  click_button "Sign up"
end

Then /^I can't sign up "([^"]*)" using:$/ do |email, table|
  step %{I can sign up "#{email}" using:}, table
  page.should have_content('Registration information is not valid')
end
