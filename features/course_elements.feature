#language:ru
Функция: Управление элементами курса(course_elements)
  Как администратор системы
  Я хочу иметь возможность создавать, редактировать и удалять элементы курса

  Сценарий: Администратор создает элемент курса
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если находится на странице курсов
    И нажимает на "HTML-верстальщик"
    И нажимает на кнопку (button) "Раздатка"
    И заполняет форму создания раздатки "Lecture - 1"
    Если нажимает на кнопку "Создать раздатку"
    То видит в списке "Lecture - 1"


  Сценарий: Администратор редактирует элемент курса
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если находится на странице курсов
    И нажимает на "HTML-верстальщик"
    И нажимает на кнопку (button) "Раздатки"
    И нажимает на кнопку "Редактировать" у раздатки "Basic HTML"
    И изменяет название раздатки на "Основы HTML"
    И нажимает на кнопку "Редактировать раздатку"
    То "Basic HTML" пропадает из списка
    И в списке появляется "Основы HTML"

  @wip
  Сценарий: Администратор удаляет элемент курса
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если находится на странице курсов
    И нажимает на кнопку (button) "Раздатки"