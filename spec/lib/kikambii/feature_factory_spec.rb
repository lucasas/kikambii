require 'spec_helper'

describe Kikambii::FeatureFactory do

  describe "#features" do

    let(:runner) { mock.as_null_object }

    before do
      Kikambii::Runner.stub(:new).and_return(runner)
    end

    context "just features" do
      subject { described_class.new failures: "features/article_images.feature features/article_related_content.feature" }

      it "should return all features" do
        subject.features.should have(2).features
      end

      it "should return feature objects" do
        subject.features.first.feature.should == "features/article_images.feature"
        subject.features.last.feature.should == "features/article_related_content.feature"
      end
    end

    context "features with runner" do
      subject { described_class.new failures: "features/article_images.feature" }

      it "should return features setting runner" do
        subject.features.first.runner.should == runner
      end
    end

    context "features with scenarios" do
      subject { described_class.new failures: "features/article_images.feature:5:20:35" }

      it "should return features" do
        subject.features.first.feature.should == "features/article_images.feature"
      end

      it "should return features setting scenarios" do
        subject.features.first.scenarios.should == ["5", "20", "35"]
      end
    end
  end
end
