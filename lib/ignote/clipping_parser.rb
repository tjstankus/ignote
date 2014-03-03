module Ignote
  class ClippingParser

    attr_reader :clipping_data

    def initialize(clipping_data)
      @clipping_data = clipping_data
    end

    def parse
      Hash.new.tap do |h|
        lines.each_with_index do |line, i|
          h[key_for_line(i)] = line
        end
      end
    end

    private

    def lines
      clipping_data.lines.each(&:strip!).reject!(&:empty?)
    end

    def key_for_line(index)
      { 0 => :publication_data,
        1 => :annotation_metadata,
        2 => :annotation_content
      }[index]
    end

  end
end
