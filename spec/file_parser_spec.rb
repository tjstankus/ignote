require_relative '../lib/ignote/file_parser'

describe Ignote::FileParser do

  let(:clippings_file_path) {
    File.expand_path(File.join(File.dirname(__FILE__),
      'fixtures', 'my_clippings.txt'))
  }

  describe '#parse' do
    let(:parser) { Ignote::FileParser.new(clippings_file_path) }
    let(:clippings) { parser.parse }

    it 'parses expected number of clippings' do
      expect(clippings.size).to eq(5)
    end
  end
end
