# -*- encoding: utf-8 -*-
# stub: active_attr 0.9.0 ruby lib

Gem::Specification.new do |s|
  s.name = "active_attr"
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Griego", "Ben Poweski"]
  s.date = "2016-01-27"
  s.description = "Create plain old ruby models without reinventing the wheel."
  s.email = ["cgriego@gmail.com", "bpoweski@gmail.com"]
  s.homepage = "https://github.com/cgriego/active_attr"
  s.rubygems_version = "2.5.1"
  s.summary = "What ActiveModel left out"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, ["< 5.1", ">= 3.0.2"])
      s.add_runtime_dependency(%q<activesupport>, ["< 5.1", ">= 3.0.2"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<factory_girl>, ["< 5.0", ">= 2.2"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<rake>, ["< 10.6", ">= 0.9.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<tzinfo>, [">= 0"])
    else
      s.add_dependency(%q<activemodel>, ["< 5.1", ">= 3.0.2"])
      s.add_dependency(%q<activesupport>, ["< 5.1", ">= 3.0.2"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<factory_girl>, ["< 5.0", ">= 2.2"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<rake>, ["< 10.6", ">= 0.9.0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<tzinfo>, [">= 0"])
    end
  else
    s.add_dependency(%q<activemodel>, ["< 5.1", ">= 3.0.2"])
    s.add_dependency(%q<activesupport>, ["< 5.1", ">= 3.0.2"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<factory_girl>, ["< 5.0", ">= 2.2"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<rake>, ["< 10.6", ">= 0.9.0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<tzinfo>, [">= 0"])
  end
end
