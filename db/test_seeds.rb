password = '12345678'
admin = User.create!(name: 'Фарид',
                     surname: 'Бабазов',
                     skype: 'farid.babazov',
                     email: 'admin@gmail.com',
                     birthdate: '06.11.1992',
                     gender: 'Мужчина',
                     first_phone: '+996772183644',
                     second_phone: '+996550362180',
                     passport_id: '123123',
                     passport_inn: '100101020',
                     issue_date: '20.12.2008',
                     issued_by: 'MVD 50-05',
                     password: password,
                     password_confirmation: password
)
User.create!(name: 'Иван',
                     surname: 'Иванов',
                     skype: 'ivan',
                     email: 'ivan@gmail.com',
                     birthdate: '06.11.1992',
                     gender: 'Мужчина',
                     first_phone: '+996772183644',
                     second_phone: '+996550362180',
                     passport_id: '123123',
                     passport_inn: '100101020',
                     issue_date: '20.12.2008',
                     issued_by: 'MVD 50-05',
                     password: password,
                     password_confirmation: password
)

SmsServiceAccount.create!(login: 'glokzs',password: 'Dgthtlrpdtplfv', user_id: 1 )
SmsServiceAccount.create!(login: 'test',password: '123123123', user_id: 1 )

Sender.create!(name: 'ITAttractor',sms_service_account_id: 1)
Sender.create!(name: 'rubykurs',sms_service_account_id: 1)
Sender.create!(name: 'webkurs.pro	',sms_service_account_id: 1)

ContactList.create!(title: 'Тестовый получатель', temp: false)
