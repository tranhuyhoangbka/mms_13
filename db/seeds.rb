User.create!(name: 'Admin',
  email: 'admin@email.com',
  password: '12345678',
  password_confirmation: '12345678',
  birthday: DateTime.new(2015, 1, 1),
  role: 'admin')