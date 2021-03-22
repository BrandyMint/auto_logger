require "test_helper"

class AutoLoggerTest < Minitest::Test
  module Custom
    extend AutoLogger
  end
  include AutoLogger

  def setup
    AutoLogger.logger_builder = nil
  end

  def test_that_it_has_a_version_number
    refute_nil ::AutoLogger::VERSION
  end

  def test_it_writes_to_log_from_instance
    assert logger.info 'test'
    assert _auto_logger_tag, 'auto_logger_test'
  end

  def test_it_writes_to_log_module
    assert Custom.logger.info 'test'
    assert Custom.send(:_auto_logger_tag), 'auto_logger_test'
  end

  def test_custom_logger_build
    AutoLogger._cached_logger = nil
    AutoLogger.logger_builder = -> (tag, default_formatter) {
      ActiveSupport::TaggedLogging.new(LogStashLogger.new(type: :stdout)).tagged tag
    }
    assert Custom.logger.info 'test'
  end
end
