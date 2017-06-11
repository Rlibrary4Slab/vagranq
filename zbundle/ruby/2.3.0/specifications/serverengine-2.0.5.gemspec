# -*- encoding: utf-8 -*-
# stub: serverengine 2.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "serverengine"
  s.version = "2.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Sadayuki Furuhashi"]
  s.date = "2017-03-01"
  s.description = "A framework to implement robust multiprocess servers like Unicorn"
  s.email = ["frsyuki@gmail.com"]
  s.homepage = "https://github.com/fluent/serverengine"
  s.licenses = ["Apache 2.0"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0")
  s.rubygems_version = "2.5.1"
  s.summary = "ServerEngine - multiprocess server framework"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sigdump>, ["~> 0.2.2"])
      s.add_development_dependency(%q<rake>, ["~> 11.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.13.0"])
      s.add_development_dependency(%q<rake-compiler-dock>, ["~> 0.5.0"])
      s.add_development_dependency(%q<rake-compiler>, ["~> 0.9.4"])
    else
      s.add_dependency(%q<sigdump>, ["~> 0.2.2"])
      s.add_dependency(%q<rake>, ["~> 11.0"])
      s.add_dependency(%q<rspec>, ["~> 2.13.0"])
      s.add_dependency(%q<rake-compiler-dock>, ["~> 0.5.0"])
      s.add_dependency(%q<rake-compiler>, ["~> 0.9.4"])
    end
  else
    s.add_dependency(%q<sigdump>, ["~> 0.2.2"])
    s.add_dependency(%q<rake>, ["~> 11.0"])
    s.add_dependency(%q<rspec>, ["~> 2.13.0"])
    s.add_dependency(%q<rake-compiler-dock>, ["~> 0.5.0"])
    s.add_dependency(%q<rake-compiler>, ["~> 0.9.4"])
  end
end
