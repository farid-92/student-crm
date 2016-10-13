#language:ru

Функция: Управление группами(groups)
  Как администратор системы
  Я хочу иметь возможность создавать, редактировать и удалять группы

  Сценарий: Администратор создает группу
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если находится на странице курсов
    И нажимает на "HTML-верстальщик"
    И нажимает на ссылку "Группа"
    И заполняет форму создания группы
      | field            | value       |
      | group_name      | HTML-верстальщик-7|
      | group_group_short_name      | HTML7|
    И нажимает на кнопку "Создать группу"
    То видит в списке "html-верстальщик-7(html7)"

  Сценарий: Администратор редактирует группу
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если находится на странице курсов
    И нажимает на "HTML-верстальщик"
    И нажимает на кнопку "Редактировать" у группы "Верстка group-1(Верстка-g1)"
    И изменяет название группы на "Верстка group-2"
    И нажимает на кнопку "Редактировать группу"
    То "Верстка group-1(Верстка-g1)" пропадает из списка
    И в списке появляется "Верстка group-2(Верстка-g1)"

  Сценарий: Администратор просматривает группу
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если находится на странице курсов
    И нажимает на "HTML-верстальщик"
    Если нажимает на ссылку "Верстка group-1(Верстка-g1)"
    То попадает на страницу группы "Верстка group-1(Верстка-g1)"

  Сценарий: Администратор удаляет группу
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если находится на странице курсов
    И нажимает на "HTML-верстальщик"
    И нажимает на кнопку "Удалить" у группы "Верстка group-1(Верстка-g1)"
    И подтверждает удаление
    То "Верстка group-1(Верстка-g1)" пропадает из списка
  @wip
  Сценарий: Администратор добавляет в группу студента
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если находится на странице курсов
    И нажимает на "HTML-верстальщик"
    И нажимает на ссылку "Верстка group-1(Верстка-g1)"
    И нажимает на кнопку добавления студента "Добавить студента"
    И видит в форме выбранным группу "Верстка group-1 (HTML-верстальщик)"
    И заполняет форму пропуская поле группы
    И нажимает на кнопку "Зарегистрировать"
    То пользователь "Doe Jane" появляется в таблице пользователей