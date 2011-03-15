# Author: Ben Nagy
# Copyright: Copyright (c) Ben Nagy, 2006-2011.
# License: The MIT License
# (See README.TXT or http://www.opensource.org/licenses/mit-license.php for details.)

require 'rubygems'
require 'trollop'
require 'drb'
require File.dirname(__FILE__) + '/lowlevel_buggery'

OPTS=Trollop::options do
    opt :port, "Port to listen on, default 8888", :type=>:integer, :default=>8888
    opt :debug, "Debug output", :type=>:boolean
end

@bugger=Buggery.new(OPTS[:debug])
p @bugger
@bugger.create_process("c:\\Program Files\\Microsoft Office\\Office12\\WINWORD.EXE")
sleep 5
exit
DRb.start_service( "druby://:#{OPTS[:port]}", @bugger )
puts "Server running at #{DRb.uri}"

trap("INT") { DRb.stop_service }
DRb.thread.join