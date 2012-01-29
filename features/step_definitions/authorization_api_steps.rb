Given /^the api key "([^"]*)" is enabled$/ do |key|
  ApiKey.create! key: key
end

Given /^the following attributes are required for registration:$/ do |table|
  APP_CONFIG["registration_properties"] = []
  table.raw.each do |property|
    APP_CONFIG["registration_properties"] << property[0]
  end
end

When /^I use the api key "([^"]*)" to create the authorization:$/ do |key, table|
  parameters = { key: key, authorization: table.rows_hash }
  post "/api/authorizations", parameters.to_json
end

Then /^I can sign up "([^"]*)" using:$/ do |email, table|
  visit sign_up_path
  table.rows_hash.each do |key, value|
    fill_in key.humanize, :with => value
  end
  click_button "Sign up"
end
