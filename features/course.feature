#language:ru
Функция: Управление курсами(course)
  Как администратор системы
  Я хочу иметь возможность создавать, редактировать и удалять курсы

  Сценарий: Администратор создает курс
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    И находится на странице курсов
    Если нажимает на ссылку "Новый курс"
    И администратор заполняет поля формы
      | field          | value       |
      | course_name     | Ruby on rails - Разработчик|
      | course_course_short_name  | Rubyist |
      | course_cost  | 13500 |
      | course_practical_time  | 108 |
      | course_theoretical_time  | 500 |
    И нажимает на кнопку "Создать курс"
    То видит в списке "Ruby on rails - Разработчик"

  Сценарий: Администратор редактирует курс
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    И находится на странице курсов
    Если нажимает на кнопку "Редактировать" у курса "HTML-верстальщик"
    И редактирует данные
      | field          | value       |
      | course_name     | Python - Разработчик|
      | course_course_short_name  | Python |
      | course_cost  | 90000 |
      | course_practical_time  | 72 |
      | course_theoretical_time  | 300 |
    И нажимает на кнопку "Редактировать курс"
    То видит в списке "Python - Разработчик"

  Сценарий: Администратор удаляет курс
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    И находится на странице курсов
    Если нажимает на кнопку "Удалить" у курса "HTML-верстальщик"
    И подтверждает удаление
    То в списке пропадает "HTML-верстальщик"
  @wip
  Сценарий: Администратор просматривает существует ли курс
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если находится на странице курсов
    То видит в списке "HTML-верстальщик"