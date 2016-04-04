#creating students
password = '12345678'
admin = User.create!(name: 'Farid',
                     surname: 'Babazov',
                     gender: 'Мужчина',
                     birthdate: '06.11.1992',
                     first_phone: '0772183644',
                     second_phone: '0550362180',
                     skype: 'farid.babazov',
                     email: 'admin@gmail.com',
                     password: password,
                     password_confirmation: password,)

20.times do
  name = Faker::Name.first_name
  surname = Faker::Name.last_name
  student = User.create!(
      name: name,
      surname: surname,
      gender: ['Мужчина', 'Женщина'].sample,
      birthdate: Faker::Date.backward,
      password: password,
      password_confirmation: password,
      email: "#{name}.#{surname}@gmail.com",
  )
end