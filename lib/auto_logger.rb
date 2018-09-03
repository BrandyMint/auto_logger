require "auto_logger/version"

# Миксин добавляет в класс метод `logger` который пишет лог
# в файл с названием класса
#
#
# Использование:
#
# class CurrencyRatesWorker
#  include AutoLogger
#
#  def perform
#   logger.info 'start'

# Чтобы указать имя лог файла используйте AutoLogger::Named:
#
# class CurrencyRatesWorker
# include AutoLogger::Named.new(name: 'filename')


module AutoLogger
  SIMPLE_FORMATTER = proc do |severity, datetime, _progname, msg|
    "#{severity.first} [#{datetime}] #{Thread.current[:request_id]}: #{msg}\n"
  end

  class Named < Module
    def self.new(name: nil)
      Module.new do
        include AutoLogger
        define_method(:_auto_logger_file_name) { name }
      end
    end
  end

  private

  # Логируем вместе с временем выполнения
  #
  def bm_log(message)
    res = nil
    bm = Benchmark.measure { res = yield }
    logger.info "#{message}: #{bm}"
    res
  end

  def logger
    @logger ||= _build_auto_logger
  end

  def _auto_logger_file_name
    self.class.to_s.underscore.gsub('/','_')
  end

  def _auto_logger_file
    filename = ("./log/#{_auto_logger_file_name}.log")
    if defined? Rails
      Rails.root.join filename
    else
      filename
    end
  end

  def _build_auto_logger
    ActiveSupport::Logger.new(_auto_logger_file).
      tap { |logger| logger.formatter = !defined?(Rails) || Rails.env.test? ? Logger::Formatter.new : CustomFormatter.new }
  end
end
