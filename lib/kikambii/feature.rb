class Kikambii::Feature

  MAXIMUM_RETRIES = 3

  attr_reader :attemps, :feature, :runner, :scenarios

  def initialize(dependencies)
    @feature, @scenarios, @runner, @attemps = dependencies[:feature], dependencies[:scenarios], dependencies[:runner], 1
  end

  def run
    return true unless should_run?

    @scenarios.delete_if { |scenario| @runner.run command_for(scenario) }
    @attemps += 1

    @scenarios.empty?
  end

  private

  def command_for(scenario)
    "#{@feature}:#{scenario}"
  end

  def should_run?
    @attemps < MAXIMUM_RETRIES
  end
end
