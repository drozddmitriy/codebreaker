Gem::Specification.new do |spec|
  spec.name = 'codebreaker'
  spec.version = '1.2.3'
  spec.summary = 'codebreaker application'
  spec.description = 'Make something that can run in production'
  spec.author = ['drozd_dmytro']
  spec.email = ['drozd.dmitriy.etc@gmail.com']
  spec.homepage = 'https://github.com/drozddmitriy/codebreaker'
  spec.files = Dir['lib/entities/*.rb', 'lib/*.rb', 'lib/modules/*.rb', 'lib/locales/*.rb', 'dependency.rb']
  spec.license = 'MIT'

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'fasterer'
  spec.add_development_dependency 'i18n'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
end
