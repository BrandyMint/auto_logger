require "test_helper"

class AutoLogger::NameTest < Minitest::Test
  include AutoLogger::Named.new(name: :custom_name)

  def test_it_writes_to_log_from_instance
    assert logger.info 'test'
    assert _auto_logger_tag, :custom_name
  end
end
