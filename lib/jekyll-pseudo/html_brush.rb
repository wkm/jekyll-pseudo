require 'jekyll-pseudo/brush'

module Jekyll
  module Pseudo
    class HtmlBrush < Jekyll::Pseudo::Brush
      def sym(txt)
        "<span class='symbol'>#{txt}</span>"
      end

      def fn(txt)
        "<span class='function'>#{txt}</span>"
      end

      def var(txt)
        "<span class='variable'>#{var}</span>"
      end

      def comment(txt)
        "<span class='comment'>/* #{txt.strip} */</span>"
      end

      def string(txt)
        "<span class='string'>#{txt}</span>"
      end

      def indent(txt)
        txt.gsub! "\t", '   '
        "<span class='indent'>#{txt}</span>"
      end

      def op(txt)
        symbol = case txt
        when '<' then '&#12296;'
        when '>' then '&#12297;'
        when '<=' then '&le;'
        when '>=' then '&ge;'
        when '<-' then '&larr;'
        when '->' then '&rarr;'
        when '*' then '&times;'
        else txt
        end
        # FIXME: html conversion for some operators
        "<span class='op'>#{symbol}</span>"
      end

      def plain(txt)
        txt
      end
    end
  end
end