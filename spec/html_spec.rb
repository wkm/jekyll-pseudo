require_relative '../lib/jekyll-pseudo.rb'
require_relative '../lib/jekyll-pseudo/mock_brush.rb'
# require 'spec_helper'

include Jekyll::Pseudo

describe HtmlBrush do
  def format(txt)
    g = Grammar.new
    g.format(txt, HtmlBrush.new)
  end

  describe "#format" do
    it "symbol span" do
      format("For").should eql "<span class='symbol'>For</span>"
    end

    it "fn span" do
      format("fn()").should eql "<span class='function'>fn</span><span class='op'>(</span><span class='op'>)</span>"
    end

    it "comment span" do
      format("# hi!").should eql "<span class='comment'>/* hi! */</span>"
    end

    it "operator converstions" do
      format("<").should eql "<span class='op'>&#12296;</span>"
      format("*").should eql "<span class='op'>&times;</span>"
    end
  end
end