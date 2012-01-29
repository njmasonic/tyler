Given /^the consumer "([^"]*)" is enabled$/ do |consumer_name|
  Consumer.create! name: consumer_name, return_url: "http://#{consumer_name}.net/sso_return"
  stub_request(:any, /sso_return/)
end

When /^I sign in as "([^"]*)" through consumer "([^"]*)"$/ do |email, consumer_name|
  step %{consumer "#{consumer_name}" sends me to the sign in page}
  fill_in "Email", :with => email
  fill_in "Password", :with => "password"
  click_button "Sign in"
end

Then /^I should be redirected to the "([^"]*)" consumer$/ do |consumer_name|
  consumer = Consumer.find_by_name(consumer_name)
  current_uri = URI.parse(current_url)
  consumer_uri = URI.parse(consumer.return_url)
  token_exp = /^token=(.*)$/
  current_uri.host.should  == consumer_uri.host
  current_uri.path.should  == consumer_uri.path
  current_uri.query.should match(token_exp)
end

Then /^I should have a valid token for "([^"]*)"$/ do |email|
  uri = URI.parse(current_url)
  token = /^token=(.*)$/.match(uri.query)[1]
  visit validate_path(token: token)
  json = ActiveSupport::JSON.decode(page.source)
  json['user']['email'].should == email
end

When /^consumer "([^"]*)" sends me to the sign in page$/ do |consumer_name|
  visit sign_in_path(consumer: consumer_name)
end
