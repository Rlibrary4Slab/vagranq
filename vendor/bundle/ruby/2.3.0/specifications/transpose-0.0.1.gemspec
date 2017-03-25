# -*- encoding: utf-8 -*-
# stub: transpose 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "transpose".freeze
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jason Ayre".freeze]
  s.date = "2014-10-25"
  s.description = "Object transformation via simple hash mapping of attributes. Great for transforming remote api objects into local models and vice versa".freeze
  s.email = ["jasonayre@gmail.com".freeze]
  s.homepage = "http://github.com/jasonayre/transpose".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Transpose (or transform) one object into another".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.6"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-pride>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry-nav>.freeze, [">= 0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-its>.freeze, ["~> 1"])
      s.add_development_dependency(%q<rspec-collection_matchers>.freeze, ["~> 1"])
      s.add_development_dependency(%q<guard>.freeze, ["~> 2"])
      s.add_development_dependency(%q<guard-rspec>.freeze, ["~> 4"])
      s.add_development_dependency(%q<guard-bundler>.freeze, ["~> 2"])
      s.add_development_dependency(%q<rb-fsevent>.freeze, [">= 0"])
      s.add_development_dependency(%q<terminal-notifier-guard>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-pride>.freeze, [">= 0"])
      s.add_dependency(%q<pry-nav>.freeze, [">= 0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-its>.freeze, ["~> 1"])
      s.add_dependency(%q<rspec-collection_matchers>.freeze, ["~> 1"])
      s.add_dependency(%q<guard>.freeze, ["~> 2"])
      s.add_dependency(%q<guard-rspec>.freeze, ["~> 4"])
      s.add_dependency(%q<guard-bundler>.freeze, ["~> 2"])
      s.add_dependency(%q<rb-fsevent>.freeze, [">= 0"])
      s.add_dependency(%q<terminal-notifier-guard>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-pride>.freeze, [">= 0"])
    s.add_dependency(%q<pry-nav>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-its>.freeze, ["~> 1"])
    s.add_dependency(%q<rspec-collection_matchers>.freeze, ["~> 1"])
    s.add_dependency(%q<guard>.freeze, ["~> 2"])
    s.add_dependency(%q<guard-rspec>.freeze, ["~> 4"])
    s.add_dependency(%q<guard-bundler>.freeze, ["~> 2"])
    s.add_dependency(%q<rb-fsevent>.freeze, [">= 0"])
    s.add_dependency(%q<terminal-notifier-guard>.freeze, [">= 0"])
  end
end
