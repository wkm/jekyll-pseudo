# jekyll-pseudo
A pseudocode/algorithm formatter for sites powered by jekyll.

Sometimes you don't want to use a particular programming language to demonstrate a concept because of the syntactic overhead. Jekyll-Pseudo lets you use a gently formatted free-formated representation.

## Language
* indentation is preserved
* a word beginning with a capital letter is a keyword
* a word followed by parentheses is a function name
* all other words are variables
* words within double quotes are generally strings

* these symbols are auto-formatted: `<-- <= >= --> =`


Sample output:

    Function swap(old, new)
      remaining <- quorum_size  @1
      success <- false

      # propose a swap
      For Each host
        result[host] <- send(host, propose[old, new])
        If result[host] = "ok"
          remaining--

      # was quorum attained
      If remaining > 1 + quorumSize / 2
        success <- true

      # execute the swap
      For Each result
        If success
          send(host, confirm[old,new])
        Else
          send(host, cancel[old,new])

## Output
Output is annotated with `<span>` classes and can be styled using CSS. Typically keywords are made bold and variables are italicized.