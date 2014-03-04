module Ignote
  class FileParser

    DELIMITER = '=' * 10

    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def parse
      file_content.split(DELIMITER).reject { |c| c.strip.empty? }
    end

    private

    def file_content
      open(file_path).read
    end

  end
end
