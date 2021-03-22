require 'logger'
require 'active_support'
require 'active_support/core_ext/string/inflections'
require 'beautiful/log'

require "auto_logger/version"
require "auto_logger/formatter"
require "auto_logger/named"

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
  DEFAULT_LOG_DIR = './log'

  mattr_accessor :log_dir, :log_formatter, :logger_builder, :_cached_logger

  def logger
    _cached_logger ||= _build_auto_logger
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

  def _auto_logger_tag
    ([Class, Module].include?(self.class) ? self.name : self.class.name).underscore.gsub('/','_')
  end

  def _auto_logger_file
    file = "#{_auto_logger_tag}.log"

    if log_dir.present?
      File.join(log_dir, file)

    elsif defined? Rails
      Rails.root.join 'log', file

    else
      File.join(DEFAULT_LOG_DIR, file)
    end
  end

  def _log_formatter
    @log_formatter || !defined?(Rails) || Rails.env.test? ? Logger::Formatter.new : Formatter.new
  end

  def _build_auto_logger
    if logger_builder.nil?
      ActiveSupport::Logger.new(_auto_logger_file).
        tap { |logger| logger.formatter = _log_formatter }
    else
      logger_builder.call(_auto_logger_tag, _log_formatter)
    end
  end
end
