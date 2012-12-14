require 'spec_helper'

describe Kikambii::Feature do

  let(:runner) { mock.as_null_object }
  subject { described_class.new feature: "feature/test.feature", scenarios: [1, 10], runner: runner }

  describe "#run" do
    it "should run feature command for each scenario" do
      runner.should_receive(:run).with("feature/test.feature:1")
      runner.should_receive(:run).with("feature/test.feature:10")

      subject.run
    end

    it "should increment attemps number" do
      subject.run
      subject.attemps.should == 1
    end

    context "when all runs were true" do
      before do
        runner.stub(:run).and_return(true)
      end

      it { subject.run.should be_true }
    end

    context "when some run fail" do
      before do
        runner.stub(:run).and_return(false)
      end

      it { subject.run.should be_false }
    end

    context "when runner return true" do
      before do
        runner.stub(:run).with("feature/test.feature:1").and_return(false)
        runner.stub(:run).with("feature/test.feature:10").and_return(true)

        subject.run
      end

      it "should not run the same scenario again" do
        runner.should_receive(:run).with("feature/test.feature:1")
        runner.should_not_receive(:run).with("feature/test.feature:10")

        subject.run
      end
    end

    context "when attemps sold up" do
      before do
        subject.instance_variable_set "@attemps", 3
      end

      it "should not run any scenario" do
        runner.should_not_receive(:run)
        subject.run
      end
    end
  end

  describe "#fail?" do
    context "when attemps sold up" do

      context "and there are scenarios to run" do
        before do
          subject.instance_variable_set "@scenarios", ["1"]
        end

        it { subject.fail?.should be_true }
      end

      context "and there aren't scenarios to run" do
        before do
          subject.instance_variable_set "@scenarios", []
        end

        it { subject.fail?.should be_false }
      end
    end
  end
end
