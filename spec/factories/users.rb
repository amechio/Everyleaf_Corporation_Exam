FactoryBot.define do
  factory :user do
    name { 'test' }
    email { 'test@test.com' }
    password { 'testdayo' }
    password_confirmation { 'testdayo' }
    role { 'normal' }
  end
  factory :second_user, class: User do
    name { 'test2' }
    email { 'test2@test2.com' }
    password { 'testdayo' }
    password_confirmation { 'testdayo' }
    role { 'normal' }
  end
  factory :third_user, class: User do
    name { 'admin' }
    email { 'admin@admin.com' }
    password { 'admindayo' }
    password_confirmation { 'admindayo' }
    role { 'admin' }
  end
  factory :forth_user, class: User do
    name { 'admin2' }
    email { 'admin2@admin2.com' }
    password { 'admindayo' }
    password_confirmation { 'admindayo' }
    role { 'admin' }
  end
end
