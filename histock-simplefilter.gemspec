require_relative 'lib/histock/simplefilter/version'

Gem::Specification.new do |spec|
    spec.name          = 'histock-simplefilter'
    spec.version       = Histock::Simplefilter::VERSION
    spec.authors       = ['Yuya Sato']
    spec.email         = ['ysato.5654@gmail.com']

    spec.summary       = 'HiStock (https://histock.tw/) filter'
    spec.homepage      = 'https://github.com/ysato5654/histock-simplefilter'
    spec.license       = 'MIT'
    spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/ysato5654/histock-simplefilter'
    spec.metadata['changelog_uri'] = 'https://github.com/ysato5654/histock-simplefilter/blob/master/CHANGELOG.md'

    # Specify which files should be added to the gem when it is released.
    # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
    spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
      `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    end
    spec.bindir        = 'exe'
    spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.require_paths = ['lib']

    spec.required_ruby_version = '~> 2.5'

    spec.add_runtime_dependency 'nokogiri', '~> 1.10.0'

    spec.add_development_dependency 'bundler', '~> 2.0'
    spec.add_development_dependency 'rake', '>= 12.3.3'
    spec.add_development_dependency 'rspec', '~> 3.0'
    spec.add_development_dependency 'travis', '>= 1.9.0'
end
