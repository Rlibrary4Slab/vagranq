# -*- encoding: utf-8 -*-
# stub: omniauth-mixi 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-mixi".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Yoichiro Tanaka".freeze]
  s.date = "2016-02-29"
  s.description = "OmniAuth strategy for mixi.".freeze
  s.email = ["yoichiro@eisbahn.jp".freeze]
  s.homepage = "https://github.com/mixi-inc/omniauth-mixi".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "OmniAuth strategy for mixi.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<omniauth>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.1"])
    else
      s.add_dependency(%q<omniauth>.freeze, ["~> 1.0"])
      s.add_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.1"])
    end
  else
    s.add_dependency(%q<omniauth>.freeze, ["~> 1.0"])
    s.add_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.1"])
  end
end
