$:.unshift File.expand_path('./lib')

require 'transmarkdownifier/version'

Gem::Specification.new do |g|
  g.name        = "transmarkdownifier"
  g.version     = Transmarkdownifier::VERSION
  g.homepage    = "http://github.com/vyder/transmarkdownifier"
  g.summary     = "Live preview of a markdown file in Chrome"
  g.description = "Loads up a live preview of a markdown file in Chrome"
  g.license     = "MIT"

  g.authors     = ["Vidur Murali"]
  g.email       = ["vidur.murali@gmail.com"]

  g.executables << 'transmarkdownify'

  g.add_dependency 'colorize', '~> 0.7.5', '>= 0.7.5'
  g.add_dependency 'github-markup', '~> 1.3.3', '>= 1.3.3'
  g.add_dependency 'listen', '~> 2.9.0', '>= 2.9.0'
  g.add_dependency 'redcarpet', '~> 3.2.2', '>= 3.2.2'
end