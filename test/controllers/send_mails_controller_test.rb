require "test_helper"

class SendMailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get send_mails_index_url
    assert_response :success
  end
end
