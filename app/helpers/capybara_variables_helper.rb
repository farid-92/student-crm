module CapybaraVariablesHelper

  def data_for_creating_new_user
    @birth_date_day_xpath = "//div[contains(@class, 'birth_date')]//div[contains(@class, 'dropdown')][1]"
    @birth_date_month_xpath = "//div[contains(@class, 'birth_date')]//div[contains(@class, 'dropdown')][2]"
    @birth_date_year_xpath = "//div[contains(@class, 'birth_date')]//div[contains(@class, 'dropdown')][3]"
    @item_xpath = "//div[contains(@class, 'item')][text()='%s']"

    @user_group_xpath = "//div[contains(@class, 'inline fields')]//div[contains(@class, 'field ')]//i"
    @user_group_select_xpath = "//div[contains(@class, 'inline fields')]//div[contains(@class, 'field ')]//div[contains(@class, 'menu')]/div[1]"

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
    @random_month = ['января', 'февраля', 'марта',
                     'апреля', 'мая', 'июня', 'июля',
                     'августа', 'сентября', 'октября',
                     'ноября', 'декабря'].sample
    @random_year = rand(1990...2005)
    @gender = ['Мужчина', 'Женщина'].sample

    @group = 'Верстка group-1 (HTML-верстальщик)'

  end

  def variables_for_creating_new_group
    @starts_at_xpath = "//div[@class='fields'][2]//div[@class='field'][1]"
    @ends_at_xpath = "//div[@class='fields'][2]//div[@class='field'][2]"
    @random_year_for_group = rand(2015...2025)
  end


end
