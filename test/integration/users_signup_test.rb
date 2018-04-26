require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end
  test "invalid signup information" do
    get signup_path

    assert_no_difference 'User.count' do

      post signup_path, params: { user: { name: "",
                                         email: "invalid@invalid",
                                         password: "foo",
                                         password_confirmation: "bar"}}
      end

      assert_template "users/new"

      assert_select 'div.field_with_errors', count: 8
      assert_select 'div#error_explanation'
      end

      test "successful signup" do
        get signup_path
          assert_difference 'User.count', 1 do

            post signup_path, params: { user: { name: "bizbuzz",
                                               email: "valid@is.valid",
                                               password: "foobar",
                                               password_confirmation: "foobar"}}
            end
            assert_equal 1, ActionMailer::Base.deliveries.size
            @user = assigns(:user)
            log_in_as @user
            assert_not is_logged_in?
            get edit_account_activation_url("invalid token", email: @user.email)
            assert_not is_logged_in?
            get edit_account_activation_url(@user.activation_token, email: "wrong email")
            assert_not is_logged_in?
            get edit_account_activation_url(@user.activation_token, email: @user.email)
            assert is_logged_in?
            follow_redirect!
            assert_template "users/show"
            assert_not flash.empty?
            assert is_logged_in?
            assert_select "a[href=?]", login_path, count: 0
            assert_select "a[href=?]", logout_path
            assert_select "a[href=?]", user_path

      end
end
