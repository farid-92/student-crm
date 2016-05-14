#language:ru
Функция: Управление курсами(course)
  Как администратор системы
  Я хочу иметь возможность создавать, редактировать и удалять курсы
  @wip
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
