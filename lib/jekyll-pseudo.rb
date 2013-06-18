require 'liquid'
require 'jekyll-pseudo/version'
require 'jekyll-pseudo/grammar'
require 'jekyll-pseudo/html_brush'

module Jekyll
  class PseudoBlock < Liquid::Block
    def initialize(tag_name, text, tokens)
      super
      @brush = Pseudo::HtmlBrush.new
      @grammar = Pseudo::Grammar.new
    end

    def render(context)
      @text = @nodelist.join('')
      @formatted = @grammar.format(@text, @brush)
      "<div class='pseudo'>#{@formatted}</div>"
    end
  end
end


Liquid::Template.register_tag('pseudo', Jekyll::PseudoBlock)