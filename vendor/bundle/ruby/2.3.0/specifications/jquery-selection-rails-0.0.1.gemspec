# -*- encoding: utf-8 -*-
# stub: jquery-selection-rails 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "jquery-selection-rails".freeze
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Masahiro Saito".freeze]
  s.date = "2012-11-22"
  s.description = "jQuery Selectin for Rails".freeze
  s.email = ["camelmasa@gmail.com".freeze]
  s.homepage = "https://github.com/camelmasa/jquery-selection-rails".freeze
  s.rubyforge_project = "jquery-selection-rails".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "jQuery Selectin for Rails".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1"])
      s.add_runtime_dependency(%q<actionpack>.freeze, [">= 3.1"])
      s.add_development_dependency(%q<rails>.freeze, [">= 3.1"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3.1"])
      s.add_dependency(%q<actionpack>.freeze, [">= 3.1"])
      s.add_dependency(%q<rails>.freeze, [">= 3.1"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.1"])
    s.add_dependency(%q<actionpack>.freeze, [">= 3.1"])
    s.add_dependency(%q<rails>.freeze, [">= 3.1"])
  end
end
