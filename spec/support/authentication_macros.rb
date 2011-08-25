module AuthenticationMacros

  def login(user = nil)
    user ||= Factory(:user)
    visit new_sessions_path
    within("#login") do
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Login'
    end
    @_current_user = user
  end

  def current_user
    @_current_user
  end

end
