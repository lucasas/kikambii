require 'bundler'
require 'bundler/gem_tasks'

desc 'rerun cucumber failures'
task :kikambii do |task|
  if File.exist?(File.join(Rails.root, 'rerun.txt'))
    failures = File.read(File.join(Rails.root, 'rerun.txt'))
    features = Kikambii::FeatureFactory.new(failures: failures).features

    features.each do |f|
      while(!f.run) do
        puts "Running feature: #{f.feature}"
      end
    end

    fail "Some features failed" if features.any? { |f| f.fail? }
  end
end
