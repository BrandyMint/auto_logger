require "test_helper"

class AutoLoggerTest < Minitest::Test
  include AutoLogger
  extend AutoLogger

  def test_that_it_has_a_version_number
    refute_nil ::AutoLogger::VERSION
  end

  def test_it_writes_to_log_from_instance
    assert logger.info 'test'
  end

  def test_it_writes_to_log_module
    assert AutoLoggerTest.logger.info 'test'
  end
end
