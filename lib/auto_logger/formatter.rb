# Source: https://blog.bigbinary.com/2014/03/03/logger-formatting-in-rails.html
module AutoLogger
  class Formatter < Beautiful::Log::Formatter
    BACKTRACE_SEVERITIES = %w(ERROR FATAL DEBUG)

    include ActiveSupport::TaggedLogging::Formatter

    def message_header(timestamp, severity, backtrace)
      header = ["[#{timestamp.strftime(datetime_format)}]"]

      if Rails.env.production?
        header << "(pida=#{$PROCESS_ID})"
        header << Thread.current[:request_id] if Thread.current[:request_id]
        header << "#{file_line(backtrace,severity)}"
      end
      #header << format('%5s', severity)
      header << severity.first

      header.join(' ')
    end

    private

    def file_line(backtrace_lines, severity)
      super backtrace_lines if BACKTRACE_SEVERITIES.include? severity
    end
  end
end
