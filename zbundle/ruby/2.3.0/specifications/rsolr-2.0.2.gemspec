# -*- encoding: utf-8 -*-
# stub: rsolr 2.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "rsolr"
  s.version = "2.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Antoine Latter", "Dmitry Lihachev", "Lucas Souza", "Peter Kieltyka", "Rob Di Marco", "Magnus Bergmark", "Jonathan Rochkind", "Chris Beer", "Craig Smith", "Randy Souza", "Colin Steele", "Peter Kieltyka", "Lorenzo Riccucci", "Mike Perham", "Mat Brown", "Shairon Toledo", "Matthew Rudy", "Fouad Mardini", "Jeremy Hinegardner", "Nathan Witmer", "Naomi Dushay", "\"shima\""]
  s.date = "2017-05-10"
  s.description = "RSolr aims to provide a simple and extensible library for working with Solr"
  s.email = ["goodieboy@gmail.com"]
  s.homepage = "https://github.com/rsolr/rsolr"
  s.licenses = ["Apache-2.0"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.requirements = ["Apache Solr"]
  s.rubyforge_project = "rsolr"
  s.rubygems_version = "2.5.1"
  s.summary = "A Ruby client for Apache Solr"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<builder>, [">= 2.1.2"])
      s.add_runtime_dependency(%q<faraday>, [">= 0"])
      s.add_development_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<nokogiri>, [">= 1.4.0"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<solr_wrapper>, [">= 0"])
    else
      s.add_dependency(%q<builder>, [">= 2.1.2"])
      s.add_dependency(%q<faraday>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 1.4.0"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<solr_wrapper>, [">= 0"])
    end
  else
    s.add_dependency(%q<builder>, [">= 2.1.2"])
    s.add_dependency(%q<faraday>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 1.4.0"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<solr_wrapper>, [">= 0"])
  end
end