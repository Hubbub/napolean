lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name = "napolean"
  gem.version = "0.9"
  gem.authors = [ "Jon Wood" ]
  gem.email = [ "jon@hubbub.co.uk" ]
  gem.description = %q{A tool to collect and submit system metrics to Librato Metrics}
  gem.summary = %q{A tool to collect and submit system metrics to Librato Metrics}
  gem.homepage = "http://github.com/hubbub/napolean"

  gem.files = `git ls-files`.split($/)
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.require_paths = [ "lib" ]

  gem.add_dependency "librato-metrics"
end
