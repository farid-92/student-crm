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