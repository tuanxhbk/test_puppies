# require_relative '../support/pages/shopping_cart_page'

Given(/^I am on the puppy adoption site$/) do
  @browser.goto 'http://puppies.herokuapp.com/'
  @home = HomePage.new(@browser)
end

When(/^I click the first View Details button$/) do
  @home.select_puppy_number 1
  @details = DetailsPage.new(@browser)
end

And(/^I click the second View Details button$/) do
  @home.select_puppy_number 2
  @details = DetailsPage.new(@browser)
end

And(/^I click the Adopt Me button$/) do
  @details.add_to_cart
  @cart = ShoppingCartPage.new(@browser)
end

And(/^I click the Adopt Another Puppy button$/) do
  @cart.continue_shopping
end

And(/^I click the Complete the Adoption button$/) do
  @cart.proceed_to_checkout
  @checkout = CheckoutPage.new(@browser)
end

And(/^I enter "([^"]*)" in the name field$/) do |name|
  @checkout.name = name
end

And(/^I enter "([^"]*)" in the address field$/) do |address|
  @checkout.address = address
end

And(/^I enter "([^"]*)" in the email field$/) do |email|
  @checkout.email = email
end

And(/^I select "([^"]*)" from the pay with dropdown$/) do |pay_type|
  @checkout.pay_type = pay_type
end

And(/^I click the Place Order button$/) do
  @checkout.place_order
end

Then(/^I should see "([^"]*)"$/) do |expected_text|
  expect(@browser.text).to include expected_text
end

Then(/^I should see "([^"]*)" as the name for line item (\d+)$/) do |name, line_item|
  # expect(cart_line_item(line_item.to_i)[1].text).to include name
  expect(@cart.name_for_line_item(line_item.to_i)).to include name
end

And(/^I should see "([^"]*)" as the subtotal for line item (\d+)$/) do |subtotal, line_item|
  # expect(cart_line_item(line_item.to_i)[3].text).to eql subtotal
  expect(@cart.subtotal_for_line_item(line_item.to_i)).to eql subtotal
end

And(/^I should see "([^"]*)" as the cart total$/) do |total|
  # expect(@browser.td(:class => 'total_cell').text).to eql total
  expect(@cart.cart_total).to eql total
end