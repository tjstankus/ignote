# Ignote

## What does Ignote do?

Nothing real at the moment. The specs pass, so there's that.

## What will Ignote do?

- Parses kindle clippings notes file (My Clippings.txt) into Ruby objects
- Maintains a file-based, local data store of clippings (in something like
  sqlite, PStore)
- Exports notes into another format
  - Evernote
- A web app (local Sinatra or Node.js) provides local browser access to notes.
  Sinatra would be easier because we can reuse the domain objects. Node.js would
  be cool because it's (much) less familiar to me and would serve as a learning
  project.
- Down the line, maybe this also handles annotations from a PDF, but at first,
  just Kindle.

## Installation

Add this line to your application's Gemfile:

    gem 'ignote'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ignote

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ignote/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
