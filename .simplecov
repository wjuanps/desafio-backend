require 'simplecov'
require 'simplecov-cobertura'

if ENV['COVERAGE']
  SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
                                                                    SimpleCov::Formatter::HTMLFormatter,
                                                                    SimpleCov::Formatter::CoberturaFormatter
                                                                  ])
  SimpleCov.start do
    add_filter 'bin/'
    add_filter 'config'
    add_filter 'db/'
    add_filter '.gitignore'
    add_filter '.gitlab-ci.yml'
    add_filter '.gitops/'
    add_filter 'vendor/'
    add_filter 'spec/'

    add_group 'Controllers', 'app/controllers/'
    add_group 'Models', 'app/models/'
    add_group 'Serializers', 'app/serializers/'
    add_group 'Services', 'app/services/'
    add_group 'Workers', 'app/workers'
    add_group 'Lib', 'lib'
  end
end
