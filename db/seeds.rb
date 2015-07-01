User.create!(
  name: 'Admin',
  email: 'admin@email.com',
  password: '12345678',
  password_confirmation: '12345678',
  birthday: DateTime.new(2015, 1, 1),
  role: 'admin')

Position.create! [
  {name: "Team Leader", abbreviation: "leader"},
  {name: "Project Manager", abbreviation: "manager"},
  {name: "Developer", abbreviation: "dev"},
  {name: "Tester", abbreviation: "tester"},
  {name: "Designer", abbreviation: "designer"},
  {name: "Bridge Engineer", abbreviation: "bridge"}]

10.times do
  User.create!(
    name: Faker::Name.first_name,
    email: Faker::Internet.safe_email,
    position_id: 3,
    password: "123456789",
    password_confirmation: "123456789",
    birthday: DateTime.new(2015, 1, 1),
    role: "user")
end

10.times do
  Team.create!(
    name: Faker::Team.name,
    description: Faker::Lorem.paragraph(3))
end

Settings.skills.each{|skill_name| Skill.create! name: skill_name}