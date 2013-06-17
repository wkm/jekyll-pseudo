# jekyll-pseudo
A simple pseudo code formatter.

## Language
* indentation is preserved
* a word beginning with a capital letter is a keyword.
* a word followed by parentheses is a function name
* all other words are variables
* words within double quotes are 

* these symbols are auto-formatted: `<-- <= >= --> =`



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
Output is formatted 