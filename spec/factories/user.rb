FactoryBot.define do
    factory :user do
        name { 'Test User' }
      email { 'user@example.com' }
      password { 'password' }
      # Add any other attributes you need for your User model
    end
  end