$:.unshift File.join(File.dirname(__FILE__))

require 'rake'
require 'redcarpet'

require 'rspec/core/rake_task'
 
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
end

task :story do |t|
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
  source = File.read('story.md') 
  target = markdown.render source
  File.open('public/story.html', 'w') do |file|
    file.print File.read('views/story-header.html')
    file.print target
  end
end
task :test    => :spec
task :default => :spec
