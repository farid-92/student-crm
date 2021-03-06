module CapybaraHelper

  include CapybaraVariablesHelper

  class ActiveRecord::Base
    mattr_accessor :shared_connection
    @@shared_connection = nil

    def self.connection
      @@shared_connection || retrieve_connection
    end
  end
  ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection



  def create_new_user(group_selected = false)
    find(:xpath, @birth_date_day_xpath).click
    find(:xpath, @birth_date_day_xpath+@item_xpath % @random_day).click

    find(:xpath, @birth_date_month_xpath).click
    find(:xpath, @birth_date_month_xpath+@item_xpath % @random_month).click

    find(:xpath, @birth_date_year_xpath).click
    find(:xpath, @birth_date_year_xpath+@item_xpath % @random_year).click

    find(:xpath, @gender_xpath).click
    find(:xpath, @gender_xpath+@gender_item_xpath % @gender).click

    fill_in 'user_first_phone', with: '+996772183644'
    fill_in 'user_second_phone', with: '+996550362180'
    fill_in 'user_passport_id', with: 'AN1001020'
    fill_in 'user_issued_by', with: 'MVD 50-05'
    fill_in 'user_passport_inn', with: '10010102305'

    find(:xpath, @issue_date_day_xpath).click
    find(:xpath, @issue_date_day_xpath+@issue_date_item_xpath % @random_day).click

    find(:xpath, @issue_date_month_xpath).click
    find(:xpath, @issue_date_month_xpath+@issue_date_item_xpath % @random_month).click

    find(:xpath, @issue_date_year_xpath).click
    find(:xpath, @issue_date_year_xpath+@issue_date_item_xpath % @random_year).click

    # find(:xpath, @group_select_xpath).click
    # find(:xpath, "//div[contains(@class, 'menu transition visible')]//div[contains(@class, 'item')][1]").click
    # find(:xpath, @student_role_xpath).click

    unless group_selected
      find(:xpath, @user_group_xpath).click
      find(:xpath, @user_group_select_xpath).click
    end

    attach_file('user[photo]', File.join(Rails.root, '/app/assets/images/test-photo.jpg'))
    attach_file('user[passport_photo]', File.join(Rails.root, '/app/assets/images/test-archive.zip'))

    # find(:xpath, "//input[@type='submit']").click
  end

  def new_group_dates
    variables_for_creating_new_group
    data_for_creating_new_user
    find(:xpath, @starts_at_xpath+"//div[(@class='ui search dropdown selection')][1]").click
    find(:xpath, @starts_at_xpath+@item_xpath % @random_day).click

    find(:xpath, @starts_at_xpath+"//div[contains(@class, 'dropdown selection')][2]").click
    find(:xpath, @starts_at_xpath+@item_xpath % @random_month).click

    find(:xpath, @starts_at_xpath+"//div[contains(@class, 'dropdown selection')][3]").click
    find(:xpath, @starts_at_xpath+@item_xpath % @random_year_for_group).click

    find(:xpath, @ends_at_xpath+"//div[contains(@class, 'dropdown selection')][1]").click
    find(:xpath, @ends_at_xpath+@item_xpath % @random_day).click

    find(:xpath, @ends_at_xpath+"//div[contains(@class, 'dropdown selection')][2]").click
    find(:xpath, @ends_at_xpath+@item_xpath % @random_month).click

    find(:xpath, @ends_at_xpath+"//div[contains(@class, 'dropdown selection')][3]").click
    find(:xpath, @ends_at_xpath+@item_xpath % @random_year_for_group).click
    # find(:xpath, @ends_at_xpath+@item_xpath % @random_year_for_group).click
  end

  def drop_in_dropzone(file_path)
    # Generate a fake input selector
    page.execute_script <<-JS
    fakeFileInput = window.$('<input/>').attr(
      {id: 'fakeFileInput', type:'file', name: 'fake_input'}
    ).appendTo('#new_sms_delivery');
    JS
    # Attach the file to the fake input selector
    attach_file('fakeFileInput', file_path)
    # Add the file to a fileList array
    page.execute_script("var fileList = [fakeFileInput.get(0).files[0]]")
    # Trigger the fake drop event
    page.execute_script <<-JS
      var e = jQuery.Event('drop', { dataTransfer : { files : [fakeFileInput.get(0).files[0]] } });
      $('#my-awesome-dropzone')[0].dropzone.listeners[0].events.drop(e);
    JS
  end


end