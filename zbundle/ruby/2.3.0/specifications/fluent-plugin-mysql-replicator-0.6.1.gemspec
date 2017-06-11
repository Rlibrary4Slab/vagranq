# -*- encoding: utf-8 -*-
# stub: fluent-plugin-mysql-replicator 0.6.1 ruby lib

Gem::Specification.new do |s|
  s.name = "fluent-plugin-mysql-replicator"
  s.version = "0.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Kentaro Yoshida"]
  s.date = "2017-04-15"
  s.email = ["y.ken.studio@gmail.com"]
  s.homepage = "https://github.com/y-ken/fluent-plugin-mysql-replicator"
  s.licenses = ["Apache-2.0"]
  s.required_ruby_version = Gem::Requirement.new("> 2.1")
  s.rubygems_version = "2.5.1"
  s.summary = "Fluentd input plugin to track insert/update/delete event from MySQL database server. Not only that, it could multiple table replication and generate nested document for Elasticsearch/Solr. It's comming support replicate to another RDB/noSQL."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<webmock>, ["~> 1.24.0"])
      s.add_development_dependency(%q<test-unit>, [">= 3.1.0"])
      s.add_runtime_dependency(%q<fluentd>, ["< 2", ">= 0.10.58"])
      s.add_runtime_dependency(%q<mysql2>, [">= 0"])
      s.add_runtime_dependency(%q<rsolr>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<webmock>, ["~> 1.24.0"])
      s.add_dependency(%q<test-unit>, [">= 3.1.0"])
      s.add_dependency(%q<fluentd>, ["< 2", ">= 0.10.58"])
      s.add_dependency(%q<mysql2>, [">= 0"])
      s.add_dependency(%q<rsolr>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<webmock>, ["~> 1.24.0"])
    s.add_dependency(%q<test-unit>, [">= 3.1.0"])
    s.add_dependency(%q<fluentd>, ["< 2", ">= 0.10.58"])
    s.add_dependency(%q<mysql2>, [">= 0"])
    s.add_dependency(%q<rsolr>, [">= 0"])
  end
end
