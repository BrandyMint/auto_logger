require "test_helper"

class AutoLoggerTest < Minitest::Test
  include AutoLogger
  extend AutoLogger

  def test_that_it_has_a_version_number
    refute_nil ::AutoLogger::VERSION
  end

  def test_it_writes_to_log_from_instance
    assert logger.info 'test'
    assert _auto_logger_file_name, 'auto_logger_test'
  end

  def test_it_writes_to_log_module
    assert AutoLoggerTest.logger.info 'test'
    assert AutoLoggerTest.send(:_auto_logger_file_name), 'auto_logger_test'
  end
end
