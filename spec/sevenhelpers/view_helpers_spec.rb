require 'spec_helper'

describe Sevenhelpers::ViewHelpers do
  let(:helper) { ActionView::Base.new }

  it "integrates with ActionView::Base" do
    ActionView::Base.new.should respond_to(:copyright_years)
  end

  describe "#copyright_years" do

    it "returns only the current year if no start_year is specified" do
      helper.copyright_years.should == Time.now.year.to_s
    end

    it "returns the current year if start_year is higher than the current year" do
      helper.copyright_years(Time.now.year + 1).should == Time.now.year.to_s
    end

    it "returns the correct range given a start_year" do
      helper.copyright_years(2010).should == "2010-#{Time.now.year.to_s}"
    end
  end

  describe "#google_analytics_code" do
    let(:tracking_id) { 'UA-111111-1' }

    it "displays the google tracking code with the tracking id embedded" do
      Rails.stub!(:env).and_return('production')
      helper.google_analytics_code(tracking_id).should match /'_setAccount', '#{tracking_id}'/
    end

    it "only displays in the production environment by default" do
      Rails.stub!(:env).and_return('development')
      helper.google_analytics_code(tracking_id).should match /<!-- actual Google Analytics code will render here in Production -->/
    end

    it "only shows in the environment(s) specified" do
      Rails.stub!(:env).and_return('development')
      helper.google_analytics_code(tracking_id, environments: %w(development test)).should match /'_setAccount', '#{tracking_id}'/
      helper.google_analytics_code(tracking_id, environments: %w(staging production)).should match /<!-- actual Google Analytics code will render here in Staging and Production -->/
    end

    it "displays a placeholder comment if in an environment that should not ping GA" do
      Rails.stub!(:env).and_return('development')
      helper.google_analytics_code(tracking_id, show_placeholder: false).should == ''
    end
  end
end