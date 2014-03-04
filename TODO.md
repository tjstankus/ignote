TODO
====

- [ ] Remove pry. Is there a way to use it across-the-board by default in bundler?

DONE
====
- [x] Take output from spec failures and make those fixtures for ClippingParser.
- [x] Move lstrip and normalize line endings behavior to ClippingParser.
- [x] Rewrite expectations/specs for FileParser to not mandate a format for the
  strings. All we need to know is that: 1) The file got split into the expected
  number of strings
