require 'bundler'
require 'bundler/gem_tasks'

desc 'rerun cucumber failures'
task :kikambii do |task|
  if File.exist?(File.join(Rails.root, 'rerun.txt'))
    failures = File.read(File.join(Rails.root, 'rerun.txt'))
    Kikambii::FeatureFactory.new(failures: failures).features.each do |f|
      while(!f.run) do
        puts "Running feature: #{f.feature}"
      end
    end
  end
end
