require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'transmission-client'))
t = Transmission::Client.new('127.0.0.1', 9091, 'transmission', 'transmission')
puts t.torrents[0].name