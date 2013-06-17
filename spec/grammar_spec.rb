require_relative '../lib/jekyll-pseudo.rb'
# require 'spec_helper'

describe Jekyll::Pseudo::Grammar do
  describe "#format" do
    it "formats symbols" do
      Grammar::format("For").should eql "s(For)"
    end
  end
end