password = '12345678'
admin = User.create!(name: 'Фарид',
                     surname: 'Бабазов',
                     gender: 'Мужчина',
                     birthdate: '06.11.1992',
                     first_phone: '+996772183644',
                     second_phone: '+996550362180',
                     skype: 'farid.babazov',
                     email: 'admin@gmail.com',
                     password: password,
                     password_confirmation: password,)
