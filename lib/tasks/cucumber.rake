require 'rake'
require 'bundler'
begin
  Bundler.setup(:runtime, :test)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

begin
 require 'cucumber/rake/task'
 Cucumber::Rake::Task.new(:features)

 # task :features => :check_dependencies
rescue LoadError
 task :features do
   abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
 end
end