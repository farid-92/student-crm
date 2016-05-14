#creating students
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

20.times do
  name = Faker::Name.first_name
  surname = Faker::Name.last_name
  student = User.create!(
      name: name,
      surname: surname,
      gender: ['Мужчина', 'Женщина'].sample,
      birthdate: Faker::Date.backward,
      first_phone: '+996700123123',
      second_phone: '+996550123321',
      password: password,
      password_confirmation: password,
      email: "#{name}.#{surname}@gmail.com",
  )
end


Course.create!(name: 'HTML-верстальщик',course_short_name: 'HTML',
               practical_time: 96,theoretical_time: 100,cost: 72000)
