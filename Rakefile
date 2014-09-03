require "bundler/setup"
require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec, :tag) do |t, task_args|
  t.rspec_opts = "--tag #{task_args[:tag]}" if task_args[:tag]
end

task :default => :spec

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I . -r lib/lol.rb"
end

desc "Clean up leftover fixtures"
task :clean_fixtures do
  puts Dir.glob("spec/fixtures/*/*").map {|f| f.gsub("spec/fixtures/", "")}.map {|f| f.split("/")}.each_with_object({}) {|e, ack| ack[e[1]] ||= []; ack[e[1]] << e[0]}.select {|k,v| v.size > 1}.map {|k,v| "spec/fixtures/#{v.first}/#{k}"}.each {|f| File.delete f}
end
