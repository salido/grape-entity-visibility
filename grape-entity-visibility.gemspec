Gem::Specification.new do |s|
  s.name     = "grape-entity-visibility"
  s.version  = "0.2"
  s.platform = Gem::Platform::RUBY
  s.homepage = "http://github.com/wyattisimo/grape-entity-visibility"
  s.summary  = "Provides a simple DSL for managing visibility hierarchies in grape entities."
  s.author   = "Jared Wyatt"
  s.email    = "j@wyatt.co"
  s.license  = "MIT"

  s.files        = Dir.glob("lib/*") + %w(LICENSE README.md)
  s.require_path = "lib"
end
