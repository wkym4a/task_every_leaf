def log_in(user)
  visit new_session_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "登録"
end

def log_out
  click_link "Log out"
end