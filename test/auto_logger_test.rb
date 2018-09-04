require "test_helper"

class AutoLoggerTest < Minitest::Test
  include AutoLogger

  def test_that_it_has_a_version_number
    refute_nil ::AutoLogger::VERSION
  end

  def test_it_writes_to_log
    assert logger.info 'test'
  end
end
