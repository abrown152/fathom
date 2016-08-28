require "test_helper"

class RequestsControllerTest < ActionController::TestCase
  # def test_sanity
  test "analysis" do
    assert_not_nil(RequestsController.call_twitter("Alysia_Brownn"))
  end
end
