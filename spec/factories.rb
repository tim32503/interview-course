# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Internet.username }
    email  { Faker::Internet.email(name: name) }
    password { Faker::Internet.password }

    trait :role_for_user do
      role { 'user' }
    end

    trait :role_for_admin do
      role { 'admin' }
    end

    factory :teacher do
      role_for_admin
    end

    factory :student do
      role_for_user

      after(:create) { |user| create(:api_access_token, user: user) }
    end
  end

  factory :api_access_token do
  end

  factory :course do
    course_name = Faker::Educator.unique.course_name

    title { course_name }
    currency { 'TWD' }
    price { Faker::Number.within(range: 100..2000) }
    course_type { course_name.split(' ')[0..-2].join(' ') }
    expiration_period { Faker::Number.between(from: 1, to: 31) }
    user factory: :teacher

    factory :available_course do
      is_launched { true }
    end

    factory :unavailable_course do
      is_launched { false }
    end
  end

  factory :order do
    lesson factory: :available_course
    expired_at { Faker::Date.in_date_period }
  end
end
