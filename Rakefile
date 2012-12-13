task :kikambii do |task|
  if File.exist?(File.join(Rails.root, 'rerun.txt'))
    failures = File.read(File.join(Rails.root, 'rerun.txt')).split " "
    failures.each do |failure|
      feature = failure.split(":").first
      failure.split(":")[1..-1].each do |scenario|
        puts "Running: #{feature}:#{scenario}"
        puts %x(bundle exec cucumber #{feature}:#{scenario} -f pretty) 
      end
    end
  end
end
