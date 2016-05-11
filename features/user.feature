#language:ru
Функция: Управление пользователем
  Как администратор системы
  Я хочу иметь возможность просматривать,добавлять, редактировать и удалять пользователя

  Структура сценария: Администратор просматривает список студентов
    Допустим залогинен пользователь под "<email>" с паролем "<password>"
    Если администратор заходит на страницу с пользователями
    То он видит таблицу с пользователями
    Примеры:
      | email           | password |
      | admin@gmail.com | 12345678 |

  Сценарий: Администратор создает нового пользователя
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    И администратор заходит на страницу с пользователями
    Если нажимает на ссылку "Новый пользователь"
    И заполняет поля формы
    И нажимает на кнопку "Зарегистрировать"
    То пользователь появляется в таблице пользователей

  Сценарий: Администратор просматривает данные пользователя "Бабазов Фарид"
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    И администратор заходит на страницу с пользователями
    Если администратор нажимает на "Бабазов Фарид"
    То он попадает на страницу с данными пользователя

  Сценарий: Администратор редактирует данные пользователя "Бабазов Фарид"
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    И администратор заходит на страницу с пользователями
    Если администратор нажимает на карандаш у пользователя "Бабазов Фарид"
    И изменяет имя и фамилию у пользователя на "Александр Гудов"
    И нажимает на кнопку "Редактировать"
    То "Бабазов Фарид" пропадает из списка
    И в списке появляется "Гудов Александр"

  Сценарий: Администратор удаляет пользователя "Бабазов Фарид"
    Допустим залогинен пользователь под "admin@gmail.com" с паролем "12345678"
    И администратор заходит на страницу с пользователями
    Если администратор нажимает корзину у "Иванов Иван"
    То "Иванов Иван" пропадает из списка