require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user1 = users(:david)
    @user = users(:michael)
  end
    test "edit with invalid params" do
      log_in_as(@user)
      get edit_user_path(@user)
      assert_template "users/edit"
      patch user_path(@user), params: {user: {name: "",
                                              email: "",
                                              password: "",
                                              password_confirmation: ",awa"}}
     assert_template "users/edit"
     assert_select 'div.field_with_errors'
     assert_select 'div#error_explanation'
    end

    test "edit with valid params" do
      log_in_as(@user)
      get edit_user_path(@user)
      assert_template "users/edit"
      patch user_path(@user), params: {user: {name: "David",
                                              email: "david@david.pl",
                                              password: "",
                                              password_confirmation: ""}}
    assert_redirected_to @user
    follow_redirect!
    @user.reload
    assert_template "users/show"
    assert_equal @user.name, "David"
    assert_equal @user.email, "david@david.pl"
    end

    test "edit with invalid user" do
      log_in_as(@user1)
        get edit_user_path(@user)
        assert flash.empty?
        assert_redirected_to root_path
      end

      test "update with invalid user" do
        log_in_as(@user1)
         patch user_path(@user), params: {user: {name: "Dave",
                                                 email: "dave@da.ve"}}
         assert_redirected_to root_path
         assert flash.empty?
         @user.reload
         assert_equal @user.name, users(:michael).name

      end

      test "friendly forwarding" do
        get edit_user_path(@user)
         log_in_as(@user)
         assert_redirected_to edit_user_path(@user)
         assert_nil session[:forwarding_url]
       end
       
end
