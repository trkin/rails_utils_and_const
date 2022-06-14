require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "create successfully" do
    # assert_difference('Registration.count') do
      post registrations_path,
        params: { registration_form: { email: "my@email.com", password: "password"  } }
    # end

    assert_redirected_to root_path
    follow_redirect!
    assert_notice_message "Successfully registered"
  end

  test "create short password" do
    # assert_difference('Registration.count') do
      post registrations_path,
        params: { registration_form: { email: "my@email.com", password: "pass"  } }
    # end

    assert_redirected_to root_path
    follow_redirect!
    assert_alert_message "Please use longer password"
  end
end
