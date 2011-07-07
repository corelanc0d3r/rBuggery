require File.dirname(__FILE__) + '/../lowlevel_buggery'

debug_client=Buggery.new
debug_client.event_callbacks.add( :load_module ) {|args|
    # args receives a hash, keys and values taken from the callback definition
    # in dbgeng.h, but converted to snake_case.
    puts(
    "Module Load:
    Name: #{args[:image_name].downcase} 
    Base Address: #{"%8.8x" % args[:base_offset]} 
    Size: 0x#{"%x" % args[:module_size]}"
    )
    0 # DEBUG_STATUS_NO_CHANGE
}
debug_client.create_process "C:\\Program Files\\Microsoft Office\\Office12\\WINWORD.EXE"
loop do
    debug_client.wait_for_event 10 # msec
end
