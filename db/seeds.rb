admin = User.create!(
  email: 'admin@admin.com',
  password: 'password',
  password_confirmation: 'password',
  role: 3
)

5.times do |n|
  # username = "user#{n+1}"
  email = "example-#{n+1}@example.org"
  password = "password"
  User.create!(
              # username: username,
              email: email,
              password: password,
              password_confirmation: password
  )
end