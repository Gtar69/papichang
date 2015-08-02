# Run with: rackup private_pub.ru -s thin -E production
require "bundler/setup"
require "yaml"
require "faye"
require "private_pub"

Faye::WebSocket.load_adapter('thin')
<<<<<<< HEAD
PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "development")
run PrivatePub.faye_app
=======

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "development")
run PrivatePub.faye_app


>>>>>>> b2b202cdaf5b193c7ba0f814d7380bf8d026fc22
