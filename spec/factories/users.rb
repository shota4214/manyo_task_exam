FactoryBot.define do
  factory :user do
    name { "test_name" }
    email { "test@test.com" }
    password { "12345678" }
    password_confirmation { "12345678"}
  end
  factory :second_user, class: User do
    name { "second_name" }
    email { "second@secont.com" }
    password { "12345678" }
    password_confirmation { "12345678"}
  end
  factory :third_user, class: User do
    name { "third_name" }
    email { "third@third.com" }
    password { "12345678" }
    password_confirmation { "12345678"}
  end
  factory :admin_user, class: User do
    name { "admin_name" }
    email { "admin@admin.com" }
    admin { "true" }
    password { "12345678" }
    password_confirmation { "12345678"}
  end
end
