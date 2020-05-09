if ENV['CI']
    require 'coveralls'
    Coveralls.wear!
    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[Coveralls::SimpleCov::Formatter]
    SimpleCov.start 'test_frameworks'
end

require 'simplecov'
SimpleCov.start do
    add_filter 'spec/histock/simplefilter_spec.rb'
end

require 'bundler/setup'
require 'histock/simplefilter'

RSpec.configure do |config|
    # Enable flags like --only-failures and --next-failure
    config.example_status_persistence_file_path = '.rspec_status'

    # Disable RSpec exposing methods globally on `Module` and `main`
    config.disable_monkey_patching!

    config.expect_with :rspec do |c|
        c.syntax = :expect
    end
end
