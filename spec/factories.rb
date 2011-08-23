FactoryGirl.define do

  factory :user do
    first_name             'Jane'
    last_name              'Doe'
    password               'jane'
    password_confirmation  'jane'
    is_admin               false
    sequence(:email){|n| 'info+#{n}@quickleft.com' }
  end

  factory :admin, :class => 'user' do
    first_name             'John'
    last_name              'Doe'
    password               'john'
    password_confirmation  'john'
    is_admin               true
  end

  factory :deleted, :class => 'user' do
    first_name  'Jake'
    last_name   'Doe'
    deleted_at  { 1.day.ago }
  end

end
