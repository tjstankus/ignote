require_relative '../lib/ignote/clipping_parser'

describe Ignote::ClippingParser do
  let(:raw_clipping) { <<CLIPPING
From Bash to Z Shell: Conquering the Command Line (Oliver Kiddle;Peter Stephenson;Jerry Peek)
- Your Highlight on Location 226-226 | Added on Friday, February 28, 2014 12:17:01 PM

most Unix systems have several kinds of shells available, and users can also customize their shells
CLIPPING
  }

 context 'given a clean clipping' do
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

    it 'removes blank lines' do
      expect(clipping_data.keys.length).to eq(3)
    end
  end

  let(:raw_clipping_dos_linebreaks) {
    "\r\nRock Your Plot: A Simple System for Plotting Your Novel (Rock Your Writing) (Yardley, Cathy)\r\n" +
    "- Your Note Location 46 | Added on Friday, November 29, 2013 11:46:53 AM\r\n\r\n\r\n" +
    "\r\nSo read this with that in mind, since my ultimate goal is literary fiction.\r\n"
  }

  context 'given a clipping with dos line endings' do
    let(:parser) { Ignote::ClippingParser.new(raw_clipping_dos_linebreaks) }
    let!(:clipping_data) { parser.parse }

    it 'parses publication data' do
      publication_data = 'Rock Your Plot: A Simple System for Plotting Your ' +
      'Novel (Rock Your Writing) (Yardley, Cathy)'
      expect(clipping_data[:publication_data]).to eq(publication_data)
    end

    it 'parses annotation metadata' do
      annotation_metadata = '- Your Note Location 46 | Added on Friday, ' +
        'November 29, 2013 11:46:53 AM'
      expect(clipping_data[:annotation_metadata]).to eq(annotation_metadata)
    end

    it 'parses annotation content' do
      annotation_content = 'So read this with that in mind, since my ultimate ' +
        'goal is literary fiction.'
      expect(clipping_data[:annotation_content]).to eq(annotation_content)
    end

    it 'removes blank lines' do
      expect(clipping_data.keys.length).to eq(3)
    end

  end
end
