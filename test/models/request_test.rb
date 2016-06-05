require "test_helper"

class RequestTest < ActiveSupport::TestCase
  def request
    @request ||= Request.new
  end

  def test_valid
    assert request.valid?
  end
end
