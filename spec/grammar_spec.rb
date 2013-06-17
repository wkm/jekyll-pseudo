require_relative '../lib/jekyll-pseudo.rb'
require_relative '../lib/jekyll-pseudo/mock_brush.rb'
# require 'spec_helper'

include Jekyll::Pseudo

describe Grammar do
  def format(txt)
    g = Grammar.new
    g.format(txt, MockBrush.new)
  end
  
  describe "#format" do
    it "ignores plain text" do
      format("plain text").should eql "plain text"
    end

    it "formats symbols" do
      format("For").should eql "sym(For)"
      format("For this").should eql "sym(For) this"
      format("If Then").should eql "sym(If) sym(Then)"
      format("If Then that").should eql ("sym(If) sym(Then) that")
    end

    it "formats comments" do
      format("oh #hi\n there").should eql "oh c(hi)\ni( )there"
    end

    it "formats operators" do
      format("For a < b").should eql("sym(For) a op(<) b")
    end

    it 'formats strings' do
      format('oh "what" a world!').should eql 'oh str("what") a world!'
    end

    it 'formats functions' do
      format('fn(b,c)').should eql('fn(fn)op(()b,cop())')
      format('fn[b,c]').should eql('fn(fn)op([)b,cop(])')
      format('fn{b,c}').should eql('fn(fn)op({)b,cop(})')
    end
  end
end