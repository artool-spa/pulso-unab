require 'test_helper'

class AlertMailerTest < ActionMailer::TestCase
  test "exception_msg" do
    mail = AlertMailer.exception_msg
    assert_equal "Exception msg", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
