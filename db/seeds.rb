User.create!(name:"shota", email:"seshiruff4214@yahoo.co.jp", password: "123456", admin:"true")

10.times do |n|
  User.create!(name:"ユーザー#{n + 1}", email:"test#{n + 1}@test.com", password: "123456")
end

User.all.each do |user|
  user.tasks.create!(title:"タイトル", content:"タスク内容#{user.name}")
end

10.times do |n|
  Label.create!(label_name:"label-#{n + 1}")
end