# -*- encoding: utf-8 -*-
# stub: pace-rails 0.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "pace-rails"
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Dan Vera"]
  s.date = "2015-03-03"
  s.description = "Pace automatic web page progress bar"
  s.email = ["dan@yovu.co"]
  s.homepage = "https://github.com/yovu/pace-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Pace automatic web page progress bar, integrated in Rails assets pipeline."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<jquery-rails>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<jquery-rails>, [">= 0"])
  end
end
