#language:ru
Функция: Управление отправителями
  Как администратор системы
  Я хочу иметь возможность просматривать,добавлять, редактировать и удалять получателей

  Сценарий: Администратор просматривает список отправителей
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если администратор заходит на страницу с получателями
    То видит в списке "Тестовый получатель"

  Сценарий: Администратор просматривает содержимое получателя
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если администратор заходит на страницу с получателями
    И нажимает на "Тестовый получатель"
    То видит в списке "Бабазов Фарид"

  Сценарий: Администратор создает получателя
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если администратор заходит на страницу с получателями
    И нажимает на ссылку "Добавить получателей"
    И заполняет форму создания получателя
    И нажимает на кнопку "Создать получателей"
    То видит в списке "test_contact_list"