module Jekyll
  module Pseudo
    class Grammar
      # format a block of text, giving html as output
      def format(txt, brush)
        results = []

        mappings = [
          [/\#(.*$)/, :comment],
          [/\b([A-Z]\w+)/, :sym],
          [/(\w+)(?=[({\[])/, :fn],
          [/(\".*?\")/, :string],
          [/(<-|->|\+\+|<=|>=|--)/, :op], # try these operations first
          [/([-()\[\]{}=<>+])/, :op],     # and these second
          [/^(\s+)/, :indent]
        ]
        
        txt.strip!

        # lazy man's parser (we don't do that backtracking business)
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

            match = upto[0][1]
            # which match?
            results << brush.method(upto[1]).call(match)
            cursor = upto[0].end(1)
          else
            # no matches remaining
            results << brush.plain(txt.slice(cursor, txt.size))
            break
          end
        end

        # puts "FINAL: #{results.inspect}"
        # puts "     = #{results.join('').inspect}"
        return results.join('')
      end
    end
  end
end