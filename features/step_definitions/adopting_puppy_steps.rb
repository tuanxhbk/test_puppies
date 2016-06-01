# require_relative '../support/pages/shopping_cart_page'

Given(/^I am on the puppy adoption site$/) do
  visit(HomePage)
  #@browser.goto 'http://puppies.herokuapp.com/'
  #@home = HomePage.new(@browser)
end

When(/^I click the View Details button for "([^"]*)"$/) do |name|
  on(HomePage).select_puppy name
end

# And(/^I click the second View Details button$/) do
#   on(HomePage).select_puppy_number 2
# end

And(/^I click the Adopt Me button$/) do
  on(DetailsPage).add_to_cart
end

And(/^I click the Adopt Another Puppy button$/) do
  on(ShoppingCartPage).continue_shopping
end

And(/^I click the Complete the Adoption button$/) do
  on(ShoppingCartPage).proceed_to_checkout
  #@checkout = CheckoutPage.new(@browser)
end

And(/^I enter "([^"]*)" in the name field$/) do |name|
  on(CheckoutPage).name = name
end

And(/^I enter "([^"]*)" in the address field$/) do |address|
  on(CheckoutPage).address = address
end

And(/^I enter "([^"]*)" in the email field$/) do |email|
  on(CheckoutPage).email = email
end

And(/^I select "([^"]*)" from the pay with dropdown$/) do |pay_type|
  on(CheckoutPage).pay_type = pay_type
end

And(/^I complete the adoption with:$/) do |table|
  on(CheckoutPage).checkout(table.hashes.first)
end

And(/^I click the Place Order button$/) do
  on(CheckoutPage).place_order
end

And(/^I complete the adoption using a Credit card$/) do
  on(CheckoutPage).checkout('pay_type' => 'Credit card')
end

And(/^I complete the adoption$/) do
  on(CheckoutPage).checkout
end

When(/^I complete the adoption of a puppy$/) do
  on(HomePage).select_puppy
  on(DetailsPage).add_to_cart
  on(ShoppingCartPage).proceed_to_checkout
  on(CheckoutPage).checkout
end

When(/^I checkout leaving the name field blank$/) do
  on(HomePage).select_puppy
  on(DetailsPage).add_to_cart
  on(ShoppingCartPage).proceed_to_checkout
  on(CheckoutPage).checkout('name' => '')
end

Then(/^I should see the error message "([^"]*)"$/) do |msg|
  expect(@current_page).to have_error_message msg
end

Then(/^I should see "([^"]*)"$/) do |expected_text|
  expect(@current_page.text).to include expected_text
end

Then(/^I should see "([^"]*)" as the name for (line item \d+)$/) do |name, line_item|
  # expect(cart_line_item(line_item.to_i)[1].text).to include name
  expect(on(ShoppingCartPage).name_for_line_item(line_item)).to include name
end

And(/^I should see "([^"]*)" as the subtotal for (line item \d+)$/) do |subtotal, line_item|
  # expect(cart_line_item(line_item.to_i)[3].text).to eql subtotal
  expect(on(ShoppingCartPage).subtotal_for_line_item(line_item)).to eql subtotal
end

And(/^I should see "([^"]*)" as the cart total$/) do |total|
  # expect(@browser.td(:class => 'total_cell').text).to eql total
  expect(on(ShoppingCartPage).cart_total).to eql total
end