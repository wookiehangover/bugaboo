FactoryGirl.define do

  factory :user do
    first_name             'Snoop'
    last_name              'Dogg'
    password               'ch@nge,me'
    password_confirmation  'ch@nge,me'
    is_admin               false
    sequence(:email)       {|n| "info+#{n}@quickleft.com" }
  end

  factory :admin, :parent => 'user' do
    first_name  'John'
    last_name   'Doe'
    is_admin    true
  end

  factory :project do
    sequence(:name)  {|n| "My test project #{n}"}
    is_active        true
  end

end
