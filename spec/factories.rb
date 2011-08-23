FactoryGirl.define do

  factory :user do
    first_name             'Jane'
    last_name              'Doe'
    password               'ch@nge,me'
    password_confirmation  'ch@nge,me'
    is_admin               false
    sequence(:email)       {|n| 'info+#{n}@quickleft.com' }
  end

  factory :admin, :parent => 'user' do
    first_name  'John'
    last_name   'Doe'
    is_admin    true
  end

  factory :deleted, :parent => 'user' do
    first_name  'Jake'
    last_name   'Doe'
    deleted_at  { 1.day.ago }
  end

end
