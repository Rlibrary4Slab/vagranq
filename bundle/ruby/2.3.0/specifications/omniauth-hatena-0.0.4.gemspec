# -*- encoding: utf-8 -*-
# stub: omniauth-hatena 0.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-hatena"
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Yuki Ito"]
  s.date = "2012-05-01"
  s.description = "OmniAuth strategy for Hatena"
  s.email = ["yuki@gnnk.net"]
  s.homepage = "https://github.com/mururu/omniauth-hatena"
  s.rubygems_version = "2.5.1"
  s.summary = "OmniAuth strategy for Hatena"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.3"])
      s.add_runtime_dependency(%q<omniauth-oauth>, ["~> 1.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.9"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2.2"])
    else
      s.add_dependency(%q<multi_json>, ["~> 1.3"])
      s.add_dependency(%q<omniauth-oauth>, ["~> 1.0"])
      s.add_dependency(%q<rspec>, ["~> 2.9"])
      s.add_dependency(%q<rake>, ["~> 0.9.2.2"])
    end
  else
    s.add_dependency(%q<multi_json>, ["~> 1.3"])
    s.add_dependency(%q<omniauth-oauth>, ["~> 1.0"])
    s.add_dependency(%q<rspec>, ["~> 2.9"])
    s.add_dependency(%q<rake>, ["~> 0.9.2.2"])
  end
end
