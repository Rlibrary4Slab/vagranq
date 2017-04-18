# -*- encoding: utf-8 -*-
# stub: capistrano-faster-assets 1.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "capistrano-faster-assets"
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Andrew Thal", "Ruben Stranders"]
  s.date = "2014-11-17"
  s.description = "Speeds up asset compilation by skipping the assets:precompile task if none of the assets were changed since last release.\nWorks *only* with Capistrano 3+.\nBased on https://coderwall.com/p/aridag\n"
  s.email = ["athal7@me.com", "r.stranders@gmail.com"]
  s.homepage = "https://github.com/capistrano-plugins/capistrano-faster-assets"
  s.rubygems_version = "2.5.1"
  s.summary = "Speeds up asset compilation if none of the assets were changed since last release."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, [">= 3.1"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<capistrano>, [">= 3.1"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<capistrano>, [">= 3.1"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
