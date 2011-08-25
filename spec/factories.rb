FactoryGirl.define do

  factory :user do
    first_name             'Snoop'
    last_name              'Dogg'
    password               'ch@nge,me'
    password_confirmation  'ch@nge,me'
    is_admin               false
    sequence(:email)       {|n| "info+#{n}@quickleft.com" }
    after_build do |u|
      u.projects << Factory(:project)
    end
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

  factory :bug do
    sequence(:summary)  {|n| "The website is down #{n}"}
    steps_to_reproduce 'Go to the website'
    current_state 'Open'
    severity 'Meh'
    user_assigned_id { Factory(:user).id }
    author_id { Factory(:user).id }
    project_id { Factory(:project).id }
  end


end
