# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{hornairs-transmission-client}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dominik Sander"]
  s.date = %q{2010-03-03}
  s.email = %q{git@dsander.de}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.markdown",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "examples/connection-example.rb",
     "hornairs-transmission-client.gemspec",
     "lib/transmission-client.rb",
     "lib/transmission-client/client.rb",
     "lib/transmission-client/connection.rb",
     "lib/transmission-client/em-connection.rb",
     "lib/transmission-client/session.rb",
     "lib/transmission-client/torrent.rb",
     "test/helper.rb",
     "test/test_transmission-rpc.rb"
  ]
  s.homepage = %q{http://github.com/hornairs/transmission-client}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A Transmission RPC Client}
  s.test_files = [
    "test/helper.rb",
     "test/test_transmission-rpc.rb",
     "examples/connection-example.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end

