# -*- encoding: utf-8 -*-
# stub: transpose 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "transpose"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jason Ayre"]
  s.date = "2014-10-25"
  s.description = "Object transformation via simple hash mapping of attributes. Great for transforming remote api objects into local models and vice versa"
  s.email = ["jasonayre@gmail.com"]
  s.homepage = "http://github.com/jasonayre/transpose"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Transpose (or transform) one object into another"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.6"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rspec-pride>, [">= 0"])
      s.add_development_dependency(%q<pry-nav>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<rspec-its>, ["~> 1"])
      s.add_development_dependency(%q<rspec-collection_matchers>, ["~> 1"])
      s.add_development_dependency(%q<guard>, ["~> 2"])
      s.add_development_dependency(%q<guard-rspec>, ["~> 4"])
      s.add_development_dependency(%q<guard-bundler>, ["~> 2"])
      s.add_development_dependency(%q<rb-fsevent>, [">= 0"])
      s.add_development_dependency(%q<terminal-notifier-guard>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.6"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rspec-pride>, [">= 0"])
      s.add_dependency(%q<pry-nav>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<rspec-its>, ["~> 1"])
      s.add_dependency(%q<rspec-collection_matchers>, ["~> 1"])
      s.add_dependency(%q<guard>, ["~> 2"])
      s.add_dependency(%q<guard-rspec>, ["~> 4"])
      s.add_dependency(%q<guard-bundler>, ["~> 2"])
      s.add_dependency(%q<rb-fsevent>, [">= 0"])
      s.add_dependency(%q<terminal-notifier-guard>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.6"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rspec-pride>, [">= 0"])
    s.add_dependency(%q<pry-nav>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<rspec-its>, ["~> 1"])
    s.add_dependency(%q<rspec-collection_matchers>, ["~> 1"])
    s.add_dependency(%q<guard>, ["~> 2"])
    s.add_dependency(%q<guard-rspec>, ["~> 4"])
    s.add_dependency(%q<guard-bundler>, ["~> 2"])
    s.add_dependency(%q<rb-fsevent>, [">= 0"])
    s.add_dependency(%q<terminal-notifier-guard>, [">= 0"])
  end
end
