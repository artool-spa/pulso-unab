require 'test_helper'

class PersonControllerTest < ActionDispatch::IntegrationTest
  test "invite friend" do
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post invite_friend_url, params: { email: 'friend@example.com' }
    end
    invite_email = ActionMailer::Base.deliveries.last
​
    assert_equal "Has sido invitado por me@example.com", invite_email.subject
    assert_equal 'friend@example.com', invite_email.to[0]
    assert_match(/Hola friend@example.com/, invite_email.body.to_s)
  end
end