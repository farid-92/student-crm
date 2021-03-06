#language:ru
Функция: Проверка аутентификации пользователя

  Сценарий: пользователь входит в систему
    Допустим пользователь зашел на логин страницу
    Если пользователь заполняет поля формы
      | field          | value       |
      | user_email     | admin@gmail.com |
      | user_password  | 12345678 |
    И пользователь нажимает на кнопку "Войти в систему"
    То пользователь попадает на главную страницу
#
 Сценарий: пользователь заполняет форму логинки не правильными данными
   Допустим пользователь зашел на логин страницу
   Если пользователь заполняет поля формы
     | field          | value       |
     | user_email     | test@gmail.com |
     | user_password  | 12345678 |
   И пользователь нажимает на кнопку "Войти в систему"
   То пользователю выдается ошибка "Неверный адрес эл. почты или пароль"
