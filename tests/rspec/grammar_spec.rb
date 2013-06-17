require_relative '../lib'
require 'spec_helper'

describe Grammar do
  describe "#format" do
    it "formats symbols" do
      Grammar::format("For").should eql "s(For)"
    end
  end
end