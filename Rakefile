require 'rake'
require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.ruby_opts = ['-r "./test/test_helper"']
end

task :console do
  require 'irb'
  require 'irb/completion'
  require 'tess_api_client'
  ARGV.clear
  IRB.start
end

task :default => :test
