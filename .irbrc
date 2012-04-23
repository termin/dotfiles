# /etc/irbrcも参照
require 'irb/completion'
IRB.conf[:AUTO_INDENT]=true
# require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 100
# wirble gemが必要. gemがインストールされていない場合の分岐を書いておきたい.
require 'wirble'
Wirble.init(:skip_prompt => :DEFAULT)
Wirble.colorize
