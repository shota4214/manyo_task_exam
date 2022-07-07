User.create!(name:"shota", email:"seshiruff4214@yahoo.co.jp", password_digest:"123456")
10.times do |n|
  User.create!(name:"ユーザー#{n + 1}", email:"test#{n + 1}@test.com", password_digest:"123456")
end