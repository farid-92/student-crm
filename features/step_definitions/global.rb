include CapybaraHelper
include CapybaraVariablesHelper

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

When(/^пользователь попадает на главную страницу$/) do
  expect(page).to have_selector('#users_table')
  expect(page).to have_content('ФИО')
end

# User

When(/^залогинен пользователь под "([^"]*)" с паролем "([^"]*)"$/) do |email, password|
  visit('/users/sign_in')
  within('#new_user') do
    fill_in 'user[email]', :with => email
    fill_in 'user[password]', :with => password
  end
  find_button('Войти в систему').click
end

When(/^администратор заходит на страницу с пользователями$/) do
  visit('/member/users')
end


When(/^он видит таблицу с пользователями$/) do
  expect(page).to have_selector('#users_table')
  expect(page).to have_content('ФИО')
end


When(/^нажимает на ссылку "([^"]*)"$/) do |button_name|
  click_link(button_name)
end


When(/^заполняет поля формы$/) do
  within('#new_user') do
    data_for_creating_new_user
    fill_in 'user_name', :with => 'Farid'
    fill_in 'user_surname', :with => 'Babazov'
    fill_in 'user_email', :with => 'farid.babazov@gmail.com'
    fill_in 'user_skype', :with => 'farid.babazov'

    create_new_user
  end

end

When(/^нажимает на кнопку "([^"]*)"$/) do |button_name|
  click_button(button_name)
end

When(/^пользователь появляется в таблице пользователей$/) do
  expect(page).to have_content('Babazov Farid')
  sleep(7)
end