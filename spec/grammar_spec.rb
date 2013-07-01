require_relative '../lib/jekyll-pseudo.rb'
require_relative '../lib/jekyll-pseudo/mock_brush.rb'

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

    it 'formats variables' do
      format('x_0').should eql ('xsub(0)')
      format('x_i').should eql ('xsub(i)')
    end    

    it 'formats functions' do
      format('fn(b,c)').should eql('fn(fn)op(()b,cop())')
      format('fn[b,c]').should eql('fn(fn)op([)b,cop(])')
      format('fn{b,c}').should eql('fn(fn)op({)b,cop(})')
    end

    it 'strips leading whitespace' do
      format("\thi\n\tthere").should eql("hi\nthere")
      format("\thi\n\t\tthere").should eql("hi\ni(\t)there")
      format("\t\thi\n\tthere").should eql("i(\t)hi\nthere")
    end
  end
end