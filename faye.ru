require 'faye'
<<<<<<< HEAD
faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
run faye_server
=======
Faye::WebSocket.load_adapter('thin')
faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
run faye_server
>>>>>>> b2b202cdaf5b193c7ba0f814d7380bf8d026fc22
