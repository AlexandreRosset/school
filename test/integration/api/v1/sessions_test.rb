require 'test_helper'

feature "Autentication" do

  describe "#create" do

    it "logs_in user with valid email+password" do

      user = User.create!(
        email: "user_1@domain.com",
        password: "password1234",
        password_confirmation: "password1234"
      )

      post api_v1_user_session_path, {
        email: user.email,
        password: user.password
      }

      assert_equal 200, last_response.status
      #assert_equal false, json_response['auth_token'].blank?
    end

  end

end
