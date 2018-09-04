module AutoLogger
  class Named < Module
    def self.new(name: nil)
      Module.new do
        include AutoLogger
        define_method(:_auto_logger_file_name) { name }
      end
    end
  end
end
