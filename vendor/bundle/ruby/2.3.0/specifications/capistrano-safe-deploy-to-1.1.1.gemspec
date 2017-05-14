# -*- encoding: utf-8 -*-
# stub: capistrano-safe-deploy-to 1.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "capistrano-safe-deploy-to"
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Bruno Sutic"]
  s.date = "2014-07-10"
  s.description = "Capistrano plugin that ensures the `deploy_to` deployment path exists and has the right permissions."
  s.email = ["bruno.sutic@gmail.com"]
  s.homepage = "https://github.com/bruno-/capistrano-safe-deploy-to"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Capistrano plugin that ensures the `deploy_to` deployment path exists and has the right permissions."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, [">= 3.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<capistrano>, [">= 3.0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<capistrano>, [">= 3.0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
