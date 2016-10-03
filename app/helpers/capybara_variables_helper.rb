module CapybaraVariablesHelper

  def data_for_creating_new_user
    @birth_date_day_xpath = "//div[contains(@class, 'birth_date')]//div[contains(@class, 'dropdown')][1]"
    @birth_date_month_xpath = "//div[contains(@class, 'birth_date')]//div[contains(@class, 'dropdown')][2]"
    @birth_date_year_xpath = "//div[contains(@class, 'birth_date')]//div[contains(@class, 'dropdown')][3]"
    @item_xpath = "//div[contains(@class, 'item')][text()='%s']"

    @gender_xpath = "//div[@class='fields']//div[contains(@class, 'gender')]//div[contains(@class, 'dropdown')]"
    @gender_item_xpath = "//div[contains(@class, 'item')][text()='%s']"

    @issue_date_day_xpath = "//div[contains(@class, 'issue')]//div[contains(@class, 'dropdown')][1]"
    @issue_date_month_xpath = "//div[contains(@class, 'issue')]//div[contains(@class, 'dropdown')][2]"
    @issue_date_year_xpath = "//div[contains(@class, 'issue')]//div[contains(@class, 'dropdown')][3]"
    @issue_date_item_xpath = "//div[contains(@class, 'item')][text()='%s']"

    # @group_select_xpath = "//div[contains(@class, 'inline')]//div[contains(@class, 'field')]//div[contains(@class, 'dropdown')]"
    # @group_select_item_xpath = "//div[contains(@class, 'item')][text()='%s']"
    #
    # @student_role_xpath = "//div[contains(@class, 'field')]//div[contains(@class, 'checkbox')][1]"
    @student_avatar_xpath = "//div[contains(@class, 'inline')]//div[contains(@class, 'field')]//input[contains(@id, 'student_avatar')]"

    # @create_contract_button = "//a[contains(@class, 'primary button')]"

    @random_day = rand(1...30)
    @random_month = ['January', 'February', 'March',
                     'April', 'May', 'June', 'July',
                     'August', 'September', 'October',
                     'November', 'December'].sample
    @random_year = rand(1980...2025)
    @gender = ['Мужщина', 'Женщина'].sample

  end

  def variables_for_creating_new_group
    @starts_at_xpath = "//div[@class='fields'][2]//div[@class='field'][1]"
    @ends_at_xpath = "//div[@class='fields'][2]//div[@class='field'][2]"
    @random_year_for_group = rand(2015...2025)
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
