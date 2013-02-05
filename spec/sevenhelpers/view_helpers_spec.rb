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

    it "displays the google tracking code with the tracking id embedded" do
      helper.google_analytics_code('UA-111111-1').should match /'_setAccount', 'UA-111111-1'/
    end

  end
end