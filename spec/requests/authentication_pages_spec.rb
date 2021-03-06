require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }
  describe "sign in page" do
  	before {visit signin_path}

  	it {should have_content('Sign in')}
  	it {should have_title('Sign in')}
  end 
  describe "sign in" do
  	before {visit signin_path}
  	describe "with invalid information" do
  		before {click_button "Sign in"}
  		it {should have_title ('Sign in')}
  		it {should have_selector('div.alert.alert-error')}

  		describe "after visiting another page" do
	        before { click_link "Home" }
	        it { should_not have_selector('div.alert.alert-error') }
      	end
      	describe "followed by signout" do
      		before{ click_button "Sign out"}
      		it {should have_link('Sign in')}
      	end
  	end

  	describe "with valid information" do
  		let(:user) {FactoryGirl.create(:user)}
  		before do
  			fill_in "Email", with: user.email.upcase
  			fill_in "Password", with: user.password
  			click_button "Sign in"
  		end
  		it {should have_title (user.name)}
  		it {should have_link('Profile', 	herf: user_path(user)) }
  		it {should have_link('Settings', herf: edit_user_path(user) )}
  		it {should have_link('Sign out', 	herf: signout_path) }
  		it {should_not have_link('Sign in'),herf: signin_path}
  	end
  end

end
