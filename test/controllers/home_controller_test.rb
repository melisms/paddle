require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  # Ensure the fixtures are loaded before the tests
  fixtures :users

  setup do
    # Clear the users table before each test
    User.delete_all
    # You can now safely reference the fixtures after clearing the table
    @user1 = users(:user_one)  # using fixture
    @user2 = users(:user_two)  # using fixture
  end

  # test "should get index" do
  #   get root_url
  #   assert_response :success
  # end
end
