FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { Faker::Internet.password }
    customer_id { Faker::Number.number(8) }
    identifier { email }

    factory :new_user do
      customer_id { nil }
      identifier { nil }
    end

    factory :real_user do
      email { 'test@example.com' }
      customer_id { 2888273 }
      identifier { email }
    end
  end
end
