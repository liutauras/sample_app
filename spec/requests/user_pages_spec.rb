require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "Sign up page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    # Code to make a user variable
    before { visit user_path(user) }
  
    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
  
  describe "signup" do

    before(:each) { visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Sign up" }.not_to change(User, :count)
      end
      it { should have_selector('div', content: "Name can't be blank") }
      
    end
    
    describe "error messages" do
      before { click_button "Sign up" }

      let(:error) { 'errors prohibited this user from being saved' }

      it { should have_selector('title', text: 'Sign up') }
      it { should have_content(error) }
    end
        
    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      describe "after saving the user" do
        before { click_button "Sign up" }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.flash.success', text: 'Welcome') }
      end
      
      
      
      # before { click_button "Sign up" }
    
      # it "should create a user" do
        # expect { click_button "Sign up" }.to change(User, :count).by(1)
      # end
      # it "should render newly create user page" do
        # pending
        # # expect { response.should render_template('users/show1231') }
        # expect { page.should redirect_to("where ?? ") }
      # end
      # it "should show flash message" do
      # describe "aaaaaaaa" do
      
        
      # end
    end
  end
end

