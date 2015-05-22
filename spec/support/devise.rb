# This support package contains modules for authenticaiting
# devise users for controller and request specs.

# This module authenticates users for request specs.#
module ValidUserRequestHelper
  # Define a method which signs in as a valid user.
  def sign_in_as_a_valid_user
    hotel_network = HotelNetwork.create! code: "ex_hotel_network"
    user = User.create! hotel_network: hotel_network, email: "example@example.com", password: "example_password", password_confirmation: "example_password"

    # We action the login request using the parameters before we begin.
    # The login requests will match these to the user we just created in the factory, and authenticate us.
    post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
  end
end

# Configure these to modules as helpers in the appropriate tests.
RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller

  # Include the help for the request specs.
  config.include ValidUserRequestHelper, type: :request
end
