require "jekyll-pseudo/version"

module Jekyll
  class PseudoTag < Liquid::Tag
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