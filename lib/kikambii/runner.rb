class Kikambii::Runner
  def run(feature)
    system "bundle exec cucumber #{feature} -f pretty"
  end
end
