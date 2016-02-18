require 'minitest/autorun'
require 'modelstack'

class ModelStackTest < Minitest::Test
  def test_version
    assert_equal "0.0.0",
      ModelStack::VERSION
  end
end