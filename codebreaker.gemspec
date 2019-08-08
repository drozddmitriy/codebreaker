Gem::Specification.new do |spec|
  spec.name	= 'codebreaker'
  spec.version = '1.1.2'
  spec.summary = 'codebreaker application'
  spec.description = 'Make something that can run in production'
  spec.author = ['drozd_dmytro']
  spec.email = ['drozd.dmitriy.etc@gmail.com']
  spec.homepage	= 'https://github.com/drozddmitriy/codebreaker'
  spec.files = Dir['lib/*.rb', 'lib/modules/*.rb', 'lib/locales/*.rb']
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  # spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'i18n'
  spec.add_development_dependency 'fasterer'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
end
