$:.unshift File.join(File.dirname(__FILE__))

require 'rake'
require 'rspec/core/rake_task'
 
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
end
task :test    => :spec
task :default => :spec
