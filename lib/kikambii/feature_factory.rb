class Kikambii::FeatureFactory

  def initialize(dependencies)
    @failures = dependencies[:failures]
  end

  def features
    features = @failures.split(/\s/)
    features.map { |feature| Kikambii::Feature.new feature: name_of(feature), scenarios: scenarios_of(feature), runner: Kikambii::Runner.new }
  end

  private

  def scenarios_of(feature)
    feature.split(/:/)[1..-1]
  end

  def name_of(feature)
    feature.split(/:/).first
  end
end
