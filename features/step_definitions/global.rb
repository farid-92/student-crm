# Login
When(/^пользователь зашел на логин страницу$/) do
  visit('/users/sign_in')
end

When(/^пользователь заполняет поля формы$/) do |table|
  # table is a table.hashes.keys # => [:field, :value]
  for row in table.hashes
    fill_in row[:field], :with => row[:value]
  end
end

When(/^пользователь нажимает на кнопку "([^"]*)"$/) do |button|
  find_button(button).click
end


When(/^пользователю выдается ошибка "([^"]*)"$/) do |error|
  expect(page).to have_content(error)
end