module Jekyll
  module Pseudo
    class HtmlBrush < Brush
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
        "<span class='comment'>#{txt}</span>"
      end

      def op(txt)
        # FIXME: html conversion for some operators
        "<span class='op'>#{txt}</span>"
      end

      def plain(txt)
        txt
      end
    end
  end
end