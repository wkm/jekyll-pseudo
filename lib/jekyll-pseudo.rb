# require 'jekyll'
require 'liquid'
require 'jekyll-pseudo/version'
require 'jekyll-pseudo/grammar'
require 'jekyll-pseudo/html_brush'

module Jekyll
  class PseudoTag < Liquid::Tag
  	@brush = Pseudo::HtmlBrush.new

    def initialize(tag_name, text, tokens)
      super
      @text = text
      @text.gsub('')
    end

    def render(context)
    end
  end
end


Liquid::Template.register_tag('pseudo_code', Jekyll::PseudoTag)