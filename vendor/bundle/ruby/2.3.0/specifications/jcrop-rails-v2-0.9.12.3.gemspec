# -*- encoding: utf-8 -*-
# stub: jcrop-rails-v2 0.9.12.3 ruby lib

Gem::Specification.new do |s|
  s.name = "jcrop-rails-v2".freeze
  s.version = "0.9.12.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Maxim Dobryakov".freeze]
  s.date = "2013-10-30"
  s.description = "Jcrop asset bundle for Rails".freeze
  s.email = ["maxim.dobryakov@gmail.com".freeze]
  s.homepage = "https://github.com/maxd/jcrop-rails-v2".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Jcrop asset bundle for Rails 3.2.x/4.0.x".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
