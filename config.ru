$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')

require 'identicon/server'

run Identicon::Server.new