# /etc/irbrc$B$b;2>H(B
require 'irb/completion'
IRB.conf[:AUTO_INDENT]=true
# require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 100
# wirble gem$B$,I,MW(B. gem$B$,%$%s%9%H!<%k$5$l$F$$$J$$>l9g$NJ,4t$r=q$$$F$*$-$?$$(B.
require 'wirble'
Wirble.init(:skip_prompt => :DEFAULT)
Wirble.colorize
