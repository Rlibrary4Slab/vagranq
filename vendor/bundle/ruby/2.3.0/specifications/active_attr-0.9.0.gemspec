# -*- encoding: utf-8 -*-
# stub: active_attr 0.9.0 ruby lib

Gem::Specification.new do |s|
  s.name = "active_attr".freeze
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chris Griego".freeze, "Ben Poweski".freeze]
  s.date = "2016-01-27"
  s.description = "Create plain old ruby models without reinventing the wheel.".freeze
  s.email = ["cgriego@gmail.com".freeze, "bpoweski@gmail.com".freeze]
  s.homepage = "https://github.com/cgriego/active_attr".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "What ActiveModel left out".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>.freeze, ["< 5.1", ">= 3.0.2"])
      s.add_runtime_dependency(%q<activesupport>.freeze, ["< 5.1", ">= 3.0.2"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<factory_girl>.freeze, ["< 5.0", ">= 2.2"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, ["< 10.6", ">= 0.9.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<tzinfo>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activemodel>.freeze, ["< 5.1", ">= 3.0.2"])
      s.add_dependency(%q<activesupport>.freeze, ["< 5.1", ">= 3.0.2"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_dependency(%q<factory_girl>.freeze, ["< 5.0", ">= 2.2"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, ["< 10.6", ">= 0.9.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<tzinfo>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activemodel>.freeze, ["< 5.1", ">= 3.0.2"])
    s.add_dependency(%q<activesupport>.freeze, ["< 5.1", ">= 3.0.2"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<factory_girl>.freeze, ["< 5.0", ">= 2.2"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, ["< 10.6", ">= 0.9.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<tzinfo>.freeze, [">= 0"])
  end
end
