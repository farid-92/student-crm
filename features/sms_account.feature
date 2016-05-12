#language:ru
Функция: Управление смс аккаунтом
  Как администратор системы
  Я хочу иметь возможность просматривать,добавлять, редактировать и удалять смс аккаунт

  Сценарий: Администратор просматривает список аккаунтов
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если администратор заходит на страницу со списком аккаунтов
    То видит аккаунт с логином "glokzs"

  Сценарий: Администратор создает аккаунт
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если администратор заходит на страницу со списком аккаунтов
    И нажимает на ссылку "Новый логин"
    И заполняет форму
      | field    | value    |
      | sms_service_account_login        | test |
      | sms_service_account_password     | 12345678 |
    То аккаунт "test" появляется в списке аккаунтов
  Сценарий: Администратор редактирует аккаунт
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если администратор заходит на страницу со списком аккаунтов
    И нажимает на кнопку "Редактировать" у "glokzs"
    И редактирует пароль
    То у аккаунта "glokzs" меняется пароль на новый "12345678"

  Сценарий: Администратор удаляет аккаунт
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    Если администратор заходит на страницу со списком аккаунтов
    И нажимает на кнопку "Удалить" у "test"
    И подтверждает удаление
    То аккаунт "test" пропадает из списка аккаунтов