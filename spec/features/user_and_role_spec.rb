require "rails_helper"

describe "with users and roles" do

  def log_in_as(user)
    visit new_user_session_path 
    fill_in("user_username", with: user.username) 
    fill_in("user_password", with: user.password) 
    click_button("sign-in")
  end

  let(:user) { create(:new_user, username: 'new_user', password: 'password') }

  it "allows a logged-in user to view the root index page" do 
    log_in_as(user)
    visit(root_path)
    expect(current_path).to eq(root_path)
  end 

  it "does not allow user to see the root page if not logged in" do 
    visit(root_path)
    expect(current_path).to eq(new_user_session_path)
  end

end