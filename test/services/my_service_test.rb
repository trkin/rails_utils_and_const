require 'test_helper'

class MyServiceTest < ActiveSupport::TestCase
  test '#perform success' do
    result = MyService.new.perform "dusan"
    assert result.success?
    assert_equal "OK", result.message
  end

  test "#perform name blank" do
    result = MyService.new.perform
    refute result.success?
    assert_equal "Name is blank", result.message
  end
end
