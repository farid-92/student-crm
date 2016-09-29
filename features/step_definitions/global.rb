include CapybaraHelper
include CapybaraVariablesHelper
# require 'bootstrap-datepicker-rails'

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
  click_link('Список пользователей')
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
end

When(/^администратор нажимает на "([^"]*)"$/) do |user|
  user = "//td//*[contains(text(), '" + user + "')]"
  find(:xpath, user).click
end

When(/^он попадает на страницу с данными пользователя$/) do
  expect(page).to have_content('Бабазов Фарид')
end

When(/^администратор нажимает на карандаш у пользователя "([^"]*)"$/) do |user_name|
  user = "//td//*[contains(text(), '" + user_name + "')]/ancestor::tr//*[@id='user_1']"
  find(:xpath, user).click
end

When(/^изменяет имя и фамилию у пользователя на "([^"]*)"$/) do |new_user|
  within('#edit_user_1') do
    fill_in 'user_name', :with => 'Александр'
    fill_in 'user_surname', :with => 'Гудов'
  end
end

When(/^"([^"]*)" пропадает из списка$/) do |name|
  page.should have_no_content(name)
end

When(/^в списке появляется "([^"]*)"$/) do |new_name|
  expect(page).to have_content(new_name)
end

When(/^администратор нажимает корзину у "([^"]*)"$/) do |name|
  account = "//td//*[contains(text(), '" + name + "')]/ancestor::tr//*[@id='delete_user_2']"
  find(:xpath, account).click
  page.driver.browser.switch_to.alert.accept
end

# sms account

When(/^администратор заходит на страницу со списком аккаунтов$/) do
  visit('/sms_service_accounts')
end

When(/^видит аккаунт с логином "([^"]*)"$/) do |login|
  expect(page).to have_content(login)
end

When(/^заполняет форму$/) do |table|
  # table is a table.hashes.keys # => [:field, :value]
  for row in table.hashes
    fill_in row[:field], :with => row[:value]
  end
  click_button('Добавить')
end

When(/^аккаунт "([^"]*)" появляется в списке аккаунтов$/) do |account|
  expect(page).to have_content(account)
end




When(/^редактирует пароль$/) do
    fill_in 'sms_service_account_password', :with => '12345678'
  click_button('Добавить')
end


When(/^у аккаунта "([^"]*)" меняется пароль на новый "([^"]*)"$/) do |account, new_password|
  account = "//td[contains(text(), '#{account}')]/../td[contains(text(), '#{new_password}')]"
  # account = "//td[contains(text(), '#{account}')]/../td/[contains(text()[last()], '#{button}')]"
  # account = "//td//*[contains(text(), '" + account + "')]/ancestor::tr//*[contains(text(), '" + new_password + "')]"
  find(:xpath, account)
end

When(/^подтверждает удаление$/) do
  page.driver.browser.switch_to.alert.accept
end

When(/^аккаунт "([^"]*)" пропадает из списка аккаунтов$/) do |account|
  page.should have_no_content(account)
end

# sender

When(/^администратор заходит на страницу с отправителями$/) do
  visit('/sms_deliveries?resource_id=3')
end

When(/^видит отправителя "([^"]*)"$/) do |sender|
  expect(page).to have_content(sender)
end

When(/^заполняет форму создания отправителя$/) do
  fill_in 'sender_name', :with => 'test_sender'
  sender_xpath = "//div[contains(@class, 'field ')]//div[contains(@class, 'dropdown')]"
  item_xpath = "//div[contains(@class, 'item')][text()='%s']"
  find(:xpath, sender_xpath).click
  find(:xpath, sender_xpath+item_xpath % 'glokzs').click
end

When(/^нажимает на кнопку "([^"]*)" у "([^"]*)"$/) do |button, element|
  element = "//td[contains(text(), '#{element}')]/../td/a[contains(text()[last()], '#{button}')]"
  find(:xpath, element).click
end


When(/^редактирует данные$/) do |table|
  # table is a table.hashes.keys # => [:field, :value]
  for row in table.hashes
    fill_in row[:field], :with => row[:value]
  end
end

When(/^администратор заходит на страницу с получателями$/) do
  visit('/sms_deliveries?resource_id=2')
end

When(/^видит в списке "([^"]*)"$/) do |item|
  expect(page).to have_content(item)
end

When(/^нажимает на "([^"]*)"$/) do |element|
  elem = "//td//*[contains(text(), '#{element}')]"
  find(:xpath, elem).click
end


When(/^заполняет форму создания получателя$/) do
  sender_xpath = "//div[contains(@class, 'field ')]//div[contains(@class, 'dropdown')]"
  item_xpath = "//div[contains(@class, 'item')][text()='%s']"
  find(:xpath, sender_xpath).click
  find(:xpath, sender_xpath+item_xpath % 'Иванов Иван').click
  find(:xpath, sender_xpath).click
  fill_in 'contact_list_title', :with => 'test_contact_list'
end


# COURSE

When(/^находится на странице курсов$/) do
  visit ('/courses')
end

When(/^администратор заполняет поля формы$/) do |table|
  # table is a table.hashes.keys # => [:field, :value]
  for row in table.hashes
    fill_in row[:field], :with => row[:value]
  end
end

When(/^нажимает на кнопку "([^"]*)" у курса "([^"]*)"$/) do |button, course|
  course = "//td//a[contains(text(), '#{course}')]/../../td/a[contains(text()[last()], '#{button}')]"
  find(:xpath, course).click
end

When(/^в списке пропадает "([^"]*)"$/) do |element|
  page.should have_no_content(element)
end

When(/^видит содержимое курса$/) do
  expect(page).to have_content('Курс HTML-верстальщик')
end

# Groups


When(/^заполняет форму создания группы$/) do |table|
  # table is a table.hashes.keys # => [:field, :value]
  for row in table.hashes
    fill_in row[:field], :with => row[:value]
  end
  new_group_dates
end

When(/^нажимает на кнопку "([^"]*)" у группы "([^"]*)"$/) do |button, arg2|
  group = "//td//a[contains(text(), '#{arg2}')]/../../td/a[contains(text()[last()], '#{button}')]"
  find(:xpath, group).click
end


When(/^изменяет название группы на "([^"]*)"$/) do |new_group_name|
  within('#edit_group_1') do
    fill_in 'group_name', :with => new_group_name
  end
end

When(/^попадает на страницу группы "([^"]*)"$/) do |group|
  expect(page).to have_content(group)
end

When(/^администратор заходить на страницу СМС рассылок$/) do
  visit('/sms_deliveries?resource_id=1')
end
#
When(/^заполняет поля формы рассылок$/) do

  within('#new_sms_delivery') do
    fill_in 'sms_delivery_title', :with => 'Event'
    fill_in 'sms_delivery[delivery_time]', :with => ''
    page.execute_script("$('#datetimepicker').val('29-10-2016 15:00')")
    find(:xpath, '/html/body/div[3]').click
    xpath_1 = "//div[contains(text(), 'Выберите отправителя')]"
    find(:xpath, xpath_1).click
    xpath_2 = "//div[contains(text(), 'ITAttractor')]"
    find(:xpath, xpath_2).select_option
    xpath_contact_list = "//*[contains(text(), 'Выберите контактный лист')]"
    find(:xpath, xpath_contact_list).click
    xpath_contact_list_2 = "//*[contains(text(), 'Тестовый получатель')]"
    find(:xpath, xpath_contact_list_2).select_option

    fill_in 'sms_delivery[content]', :with => 'Test test. колега предупредите если пришло'

  end
end

When(/^нажимает на кнопку "([^"]*)" у рассылки "([^"]*)"$/) do |button, title|
  delivery = "//td[contains(text(), '#{title}')]/following-sibling::td//div/a[contains(text()[last()], '#{button}')]"
  # delivery = '//*[@id="sms-tab"]/table/tbody/tr/td[5]/div/a[1]'
  find(:xpath, delivery).click
end

#//td[contains(text(), 'вапывп')]/following-sibling::td//div/a[contains(text()[last()], 'Редактировать')]

When(/^изменяет название рассылки на "([^"]*)"$/) do |arg|
  fill_in 'sms_delivery[delivery_time]', :with => ''
  page.execute_script("$('#datetimepicker').val('#{arg}')")
end

When(/^заполняет поля формы рассылок без даты отправки$/) do
  within('#new_sms_delivery') do
    fill_in 'sms_delivery_title', :with => 'Event'

    find(:xpath, '/html/body/div[3]').click
    xpath_1 = "//div[contains(text(), 'Выберите отправителя')]"
    find(:xpath, xpath_1).click
    xpath_2 = "//div[contains(text(), 'ITAttractor')]"
    find(:xpath, xpath_2).select_option
    xpath_contact_list = "//*[contains(text(), 'Выберите контактный лист')]"
    find(:xpath, xpath_contact_list).click
    xpath_contact_list_2 = "//*[contains(text(), 'Тестовый получатель')]"
    find(:xpath, xpath_contact_list_2).select_option

    fill_in 'sms_delivery[content]', :with => 'Test test. колега предупредите если пришло'

  end
end