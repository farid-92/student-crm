#language:ru
Функция: Управление группами(groups)
  Как администратор системы
  Я хочу иметь возможность создавать, редактировать и удалять группы
  @wip
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
    То видит в списке "HTML-верстальщик-7(HTML7)"