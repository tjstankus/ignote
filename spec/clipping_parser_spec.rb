require_relative '../lib/ignote/clipping_parser'

describe Ignote::ClippingParser do
  let(:raw_clipping) { <<CLIPPING
From Bash to Z Shell: Conquering the Command Line (Oliver Kiddle;Peter Stephenson;Jerry Peek)
- Your Highlight on Location 226-226 | Added on Friday, February 28, 2014 12:17:01 PM

most Unix systems have several kinds of shells available, and users can also customize their shells
CLIPPING
  }

  let(:parser) { Ignote::ClippingParser.new(raw_clipping) }
  let!(:clipping_data) { parser.parse }

  it 'parses publication data' do
    publication_data = 'From Bash to Z Shell: Conquering the Command Line ' +
      '(Oliver Kiddle;Peter Stephenson;Jerry Peek)'
    expect(clipping_data[:publication_data]).to eq(publication_data)
  end

  it 'parses annotation metadata' do
    annotation_metadata = '- Your Highlight on Location 226-226 | ' +
      'Added on Friday, February 28, 2014 12:17:01 PM'
    expect(clipping_data[:annotation_metadata]).to eq(annotation_metadata)
  end

  it 'parses annotation content' do
    annotation_content = 'most Unix systems have several kinds of shells ' +
      'available, and users can also customize their shells'
    expect(clipping_data[:annotation_content]).to eq(annotation_content)
  end

  it 'removes blank line' do
    expect(clipping_data.keys.length).to eq(3)
  end
end
