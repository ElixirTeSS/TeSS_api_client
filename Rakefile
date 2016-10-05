require 'rake'
require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

task :console do
  require 'irb'
  require 'irb/completion'
  require 'tess_api_client'
  ARGV.clear
  IRB.start
end
