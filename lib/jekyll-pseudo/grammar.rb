module Jekyll
  module Pseudo
    class Grammar
      # parse a block of text, using the given brush to format output (works in a single pass)
      def format(txt, brush)
        results = []

        mappings = [
          [/\#(.*$)/, :comment],
          [/\b([A-Z]\w+)/, :sym],
          [/(\w+)(?=[({\[])/, :fn],
          [/(\".*?\")/, :string],
          [/(<-|->|\+\+|<=|>=|--)/, :op],  # try these operators first
          [/([-()\[\]{}=<>+*])/, :op],     # and these second
          [/\b([a-z][a-zA-Z0-9]*)(_[a-zA-Z0-9]+)?/, :var],
          [/^(\s+)/, :indent]
        ]

        # replace tabs with three spaces
        txt.gsub! /^\t/, '   '

        # count leading whitespace
        ws = txt.scan(/^ */).map do |leading|
          leading.size
        end
        leading = (ws.min or 0)

        # remove leading whitespace of the given length
        if leading > 0
          r = /^ {#{leading}}/
          txt.gsub! r, ''
        end

        # lazy man's parser (we don't do any of that silly backtracking)
        cursor = 0
        while true
          matches = mappings.map do |pair|
            [pair[0].match(txt, cursor), pair[1]]
          end

          upto = matches.min_by do |pair|
            matchdata = pair[0]
            if matchdata == nil
              txt.size
            else
              matchdata.begin(0)
            end
          end

          if upto[0] != nil
            results << brush.plain(txt.slice(cursor, upto[0].begin(0)-cursor))

            # which match?
            captures = upto[0].captures
            results << brush.method(upto[1]).call(*captures)
            cursor = upto[0].end(0)
          else
            # no matches remaining
            results << brush.plain(txt.slice(cursor, txt.size))
            break
          end
        end

        return results.join('')
      end
    end
  end
end